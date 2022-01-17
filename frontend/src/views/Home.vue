<template>
    <b-row class="home-container pr-4">
        <b-col xl="7">
            <b-row>
                <b-col cols="12">
                    <div class="container home-container_info">
                        <div class="info_title" >
                            <h5> Тариф {{profile.tariff.name}} </h5>
                        </div>
                        <h1> {{profile.client.phone}} </h1>
                        <p> {{profile.client.name}} </p>
                    </div>
                </b-col>
                <b-col cols="12">
                    <div class="container home-container_resources">
                        <h2>Остатки</h2>
                        <b-row class="resources">
                            <b-col col lg="2" md="10" sm="10">
                                <h4>Интернет</h4>
                            </b-col>
                            <b-col col lg="8" md="9" sm="9">
                                <b-progress :max="profile.tariffResources.internet" class="resources_progress">
                                    <b-progress-bar class="resources_progressbar" :value="profile.clientResources.internet">
                                        <span></span>
                                    </b-progress-bar>
                                </b-progress>
                            </b-col>
                            <b-col cols="1">
                                <h4>{{ percentInternet }}%</h4>
                            </b-col>
                        </b-row>
                        <b-row class="resources">
                            <b-col col lg="2" md="10" sm="10">
                                <h4>Звонки</h4>
                            </b-col>
                            <b-col col lg="8" md="9" sm="9">
                                <b-progress :max="profile.tariffResources.calls" class="resources_progress">
                                    <b-progress-bar class="resources_progressbar" :value="profile.clientResources.calls">
                                        <span></span>
                                    </b-progress-bar>
                                </b-progress>
                            </b-col>
                            <b-col cols="1">
                                <h4>{{ percentCalss }}%</h4>
                            </b-col>
                        </b-row>
                        <b-row class="resources">
                            <b-col col lg="2" md="10" sm="10">
                                <h4>CMC</h4>
                            </b-col>
                            <b-col col lg="8" md="9" sm="9">
                                <b-progress :max="profile.tariffResources.sms" class="resources_progress">
                                    <b-progress-bar class="resources_progressbar" :value="profile.clientResources.sms">
                                        <span></span>
                                    </b-progress-bar>
                                </b-progress>
                            </b-col>
                            <b-col cols="1">
                                <h4>{{ percentSMS }}%</h4>
                            </b-col>
                        </b-row>
                    </div>
                </b-col>
            </b-row>
        </b-col>
        <b-col xl="5">
            <div class="container home-container_balance balance">
                <h2>Баланс</h2>
                <h1>{{profile.balance.balance}} руб</h1>
                <p>
                    Абонентская плата {{ profile.tariff.price }} ₽ будет списана 21 сентября
                </p>
                <b-button class="balance_btn" size="lg" :to="{ name: 'Pay' }">
                    Пополнить баланс
                </b-button>
            </div>
        </b-col>
    </b-row>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
export default {
    name: "Home",
    computed: {
        ...mapGetters({
            profile: "profile",
        }),
        percentInternet(){
            return (this.profile.clientResources.internet / this.profile.tariffResources.internet  * 100).toFixed(2)
        },
        percentCalss(){
            return (this.profile.clientResources.calls / this.profile.tariffResources.calls  * 100).toFixed(2)
        },
        percentSMS(){
            return (this.profile.clientResources.sms / this.profile.tariffResources.sms  * 100).toFixed(2)
        },
    },
    methods: {
        ...mapActions({
            getProfile: "getProfile",
        }),
    },
    created() {
        this.getProfile();
    },
}
</script>

<style lang="scss">
    .home-container{
        padding-top: 2%;
        padding-bottom: 2%;

        &_info{
            height: 210px;

            .info{
                &_title{
                    width: 100%;
                    padding: 2%;
                    h5{
                        float: right;
                    }
                }
            }
        }

        &_resources{
            margin-top: 20px;
            height: 520px;
            margin-bottom: 2%;

            h2{
                margin-bottom: 7%;
            }
            .resources{
                margin-bottom: 3.5%;

                &_progress{
                    height: 0.4rem;
                    background: #596372;
                    margin-top: 1rem;
                    border-radius: 0px
                }

                &_progressbar{
                    background: linear-gradient(70deg, #84bdbd, #5EF0E7);

                }
            }
        }

        &_balance{
            height: 420px;
            h1{
                margin-top: 4%;
            }

            .balance{
                &_btn{
                    margin: 3%;
                    margin-top: 145px;
                    background: #5477a4;
                    border: none;
                }
                &_btn:hover{
                    transition: all 0.6s;
                    background-color: #92acce;
                }
            }
        }

    }
</style>