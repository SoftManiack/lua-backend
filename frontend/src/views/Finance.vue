<template>
    <div class="finance-container pr-4">
        <h1>Операции</h1>
        <div class=" p-4" per-page="3">
            <b-table
                id="finance-container_table"
                class="finance-container_table"
                :fields="fields"
                :items="operations"
                :per-page="perPage"
                :current-page=currentPage
                :tbody-tr-class="rowClass"
                 stacked="sm"
            ></b-table>
            <b-pagination
                class="finance-container_plagination mt-4"
                v-model=currentPage
                :total-rows="operations.length"
                :per-page="perPage"
                aria-controls="finance-container_table"
            ></b-pagination>
        </div>
    </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";

export default {
    name: "Finance",
    data(){
        return{
            perPage: 12,
            currentPage: 1,
            fields: [
                {
                    key: 'amount',
                },
                {
                    key: 'tsform',
                    formatter: value => {
                        return value.split('.')[0]
                    }
                },
                {
                    key: 'name',
                },
            ]
        }
    },
    computed: {
        ...mapGetters({
            operations: "operations",
        }),
    },
    methods: {
        ...mapActions({
            getOperations: "getOperations",
        }),
        rowClass(item, type) {
            if (!item || type !== 'row') return
            if (item.name === "Пополнение") return 'row-payment'
            if (item.name === "Списание") return 'row-withdrawal'
        }
    },
    mounted() {
        this.getOperations();
    },

}
</script>

<style lang="scss">
    .finance-container{
        padding-top: 2%;
        padding-bottom: 2%;

        &_table{
            color: #bdcee5 !important;

            .row-payment{
                color: #61c4a1
            }
            .row-withdrawal{
                color: #e37777
            }
        }

        &_plagination > li > a{
            color: #61DDE4  !important;
        }
    }
</style>