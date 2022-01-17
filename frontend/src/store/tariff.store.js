import { getTariffs, updateTariff } from '@/services/tariff.service';

const mutations = {
    SET_TARIFFS(state, tariffs) {
        state.tariffs = tariffs;
    },
    STATUS_TARIFF(state, data) {
        state.status = data;
    },
    TARIFF_ERROR(state, error) {
        state.error = error;
    },
}

const actions = {
    async getTariffs({ commit }) {
            const { data, error } = await getTariffs();
            if(data){
                commit("SET_TARIFFS", data)
            }else{
                commit("TARIFF_ERROR", error);
            }
    },
    async updateTariff({ commit }, uid) {
            const { data, error } = await updateTariff(uid);
            if(data){
                commit("STATUS_TARIFF", data)
            }else{
                commit("TARIFF_ERROR", error);
            }
    },
}

const getters = {
    tariffs: (state) => state.tariffs,
}

const state = () => ({
    error: '',
    tariffs: {},
    status: ''
})

export default {
    mutations,
    getters,
    actions,
    state,
}