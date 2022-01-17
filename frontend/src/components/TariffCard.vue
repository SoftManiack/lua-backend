<template>
        <div class="tariff-container_card container tariff-card">
            <h5>{{ name }}</h5>
            <b-row class="mt-4 px-2">
                <b-col cols="2">
                    <i class="fas fa-globe tariff-card_icon"></i>
                </b-col>
                <b-col cols="10">
                    <p> {{ internet | convertGb}} Гб</p>
                </b-col>
            </b-row>
            <b-row class="mt-2 px-2">
                <b-col cols="2">
                    <i class="fas fa-sms tariff-card_icon"></i>
                </b-col>
                <b-col cols="10">
                    <p> {{ sms }} </p>
                </b-col>
            </b-row>
            <b-row class="mt-2 px-2">
                <b-col cols="2">
                    <i class="fas fa-phone-alt tariff-card_icon"></i>
                </b-col>
                <b-col cols="10">
                    <p> {{ calls }} мин</p>
                </b-col>
            </b-row>
            <b-row class="mt-4 px-2">
                <b-col cols="12">
                    <h2>Цена: {{ price }} ₽</h2>
                </b-col>
            </b-row>
            <b-row class="mt-2 px-4">
                <b-button class="tariff-card_btn" @click="$emit('updateTariff')" :disabled="profile.tariff.uid == uid">
                    Выбрать
                </b-button>
            </b-row>
        </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
    name: "TariffCard",
    computed: {
        ...mapGetters({
            profile: "profile",
        }),
    },
    filters: {
        convertGb: function (value) {
            if (!value) return ''
            value = Number(value)
            return value / 1024
        }
    },
    props: {
        uid: { type: String, default: ""},
        name: { type: String, default: ""},
        price: { type: Number, default: 0 },
        days: { type: Number, default: 0 },
        internet: { type: Number, default: 0 },
        sms: { type: Number, default: 0 },
        calls: { type: Number, default: 0 },
    },
    emits: ['updateTariff']
}
</script>

<style lang="scss">

</style>