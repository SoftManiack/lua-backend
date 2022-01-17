<template>
    <div class="pay-container">
        <b-row align-h="center">
            <b-col col xl="9" lg="10" md="11">
                <h1>Пополнение баланса</h1>
            </b-col>
            <b-col col xl="1" lg="1" md="1">
                <router-link :to="{ name: 'Home' }" >
                    <i class="fas fa-times" ></i>
                </router-link>
            </b-col>
        </b-row>
        <b-row align-h="center" px="4">
            <b-col col xl="6" class="pay-container_form">
                <b-row class="form-container">
                    <b-col col xl="6" md="12">
                        <b-form-input placeholder="7 777 777 77 77" class="form-container_input"></b-form-input>
                    </b-col>
                    <b-col col xl="6" md="12">
                        <b-form-input
                            placeholder="Сумма, ₽ (от 100 до 10000)"
                            class="form-container_input"
                            v-model="$v.amount.$model"
                            :state="validateState()"
                        ></b-form-input>
                    </b-col>
                    <b-col col cols="12">
                        <b-form-input placeholder="Номер банковской карты XXXX XXXX XXXX XXXX" class="form-container_input"></b-form-input>
                    </b-col>
                    <b-col col xl="6" md="6">
                        <b-form-input placeholder="ММ/ГГ" class="form-container_input"></b-form-input>
                    </b-col>
                    <b-col col xl="6" md="6">
                        <b-form-input placeholder="CVV/CVC" class="form-container_input"></b-form-input>
                    </b-col>
                    <b-col col xl="12" md="12">
                        <b-form-input placeholder="email для отправки письма" class="form-container_input"></b-form-input>
                    </b-col>
                </b-row>
            </b-col>
            <b-col col xl="4" class="pay-container_summary summary-container">
                <b-row class="summary-container_header">
                    <b-col cols="10">
                        <h1>Итого к зачислению</h1>
                    </b-col>
                    <b-col cols="10">
                        <h4>{{ amount }} ₽</h4>
                        <p>Без комисии</p>
                    </b-col>
                </b-row>
                <b-row>
                    <b-button class="summary-container_btn" @click="pay">
                        Оплатить
                    </b-button>
                </b-row>
                <b-row class="summary-container_сonvention">
                    <p>Нажимая "Оплатить" вы подтверждаете согласие с
                        <a href="#">Условиями предоставление услуги</a>
                    </p>
                </b-row>
            </b-col>
        </b-row>
    </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import router                   from "../router";

import {
    required,
    numeric,
    between
} from "vuelidate/lib/validators";
import { validationMixin } from "vuelidate";

export default {
    name: "Pay",
    mixins: [validationMixin],
    data() {
        return{
            amount: 0
        }
    },
    validations: {
        amount: {
            required,
            numeric,
            between: between(100, 10000)
        }
    },
    computed: {
        ...mapGetters({
            error: "error"
        })
    },
    methods: {
        ...mapActions({
            operationPay: "operationPay",
        }),
        validateState(){
            const { $dirty, $error } = this.$v.amount;
            return $dirty ? !$error : null;
        },
        async pay(){
            this.$v.$touch();
            await this.operationPay(this.amount);

            if(!this.error){
                router.push('/')
            }
        }
    },
}
</script>

<style lang="scss">
    .pay-container{
        padding: 2%;

        .fa-times{
            font-size: 2rem;
            color: #ffffff;
            cursor: pointer;
        }

        &_form {
            margin-top: 3%;
            height: 700px;
            border: 1px solid rgba(85, 105, 131, 0.5);

            .form-container{
                padding: 4%;
                &_input{
                    padding:3%;
                    border-radius: 0;
                    margin-bottom: 9%;
                    border: none;
                    background-color: #252F3C;
                    border-bottom: 1px solid #bdcee5;
                    font-size: 1.3rem;
                }
                &_input:focus{
                    background-color:  #252F3C;
                    outline: none;
                    box-shadow: none;
                    border-color: #5477a4;
                }
            }
        }

        &_summary {
            margin-top: 3%;
            height: 700px;
            border: 1px solid rgba(85, 105, 131, 0.5);

            .summary-container{
                &_header{
                    padding: 2%;
                }
                &_btn{
                    margin: 5%;
                    padding: 3%;
                    width: 30%;
                    background: #61c4a1;
                    border-radius: 2%;
                    border: none;
                }
                &_btn:hover{
                    transition: all 0.6s;
                    background-color: #61c4a1;
                }
                &_сonvention{
                    padding-left: 5%;
                    padding-right: 5%;

                    a{
                        color: #eaeef6;
                        text-decoration-line: underline;
                    }
                }
            }
        }
    }
</style>