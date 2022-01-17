<template>
    <div class="tariff-container pr-4">
        <h1 class="p-1">Тарифы</h1>
        <b-row>
            <b-col v-for="(tariff, key) in tariffs" :key="key" col xl="3" lg="4" md="6" sm="12" >
                <TariffCard
                    :uid="tariff.uid"
                    :name="tariff.name"
                    :price="tariff.price"
                    :days="tariff.days"
                    :internet="tariff.internet"
                    :sms="tariff.sms"
                    :calls="tariff.calls"
                    @updateTariff="update(tariff.uid)"
                />
            </b-col>
        </b-row>
    </div>
</template>

<script>
import TariffCard                from "@/components/TariffCard";
import { mapGetters, mapActions} from 'vuex'
import router                    from "../router";
import { updateTariff }            from "../services/tariff.service";

export default {
    name: "Tariffs",
    components: {
        TariffCard
    },
    computed: {
        ...mapGetters({
            tariffs: "tariffs",
            error: "error"
        }),
    },
    methods: {
        ...mapActions({
            getTariffs: "getTariffs",
            updateTariff: "updateTariff"
        }),
        async update(uid){
            await updateTariff(uid)
            if(!this.error){
                router.push('/')
            }
        }
    },
    mounted() {
        this.getTariffs();
    },
}
</script>

<style lang="scss">
    .tariff-container{
        margin-top: 1%;

        &_card{
            margin-top: 4%;
            margin-bottom: 4%;
            height: 390px;
            border-top: 1px solid #929aab;
            border-left: 1px solid #929aab;
            border-right: 1px solid #929aab;
            border-bottom: 1px solid #929aab;

            h5{
                font-size: 1.5rem;
                margin: 1%;
            }

            .tariff-card{
                &_icon{
                    color: #eaeef6;
                    font-size: 1.9rem;
                }
                &_btn{
                    border: none;
                    margin-top: 5%;
                    background: #5477a4;
                };
                &_btn:hover{
                    transition: 1s all;
                    background: #92acce;
                }
            }
        }

        &_card:hover{
            transition: 0.3s all;
            border-top: 1px solid #8ac2af;
            border-left: 1px solid #8ac2af;
            border-right: 1px solid #8ac2af;
            border-bottom: 1px solid #8ac2af;
        }
    }
</style>