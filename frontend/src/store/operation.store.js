import { getOperations, operationPay } from '@/services/operation.service';

const mutations = {
    SET_OPERATIONS(state, operations) {
        state.operations = operations;
    },
    OPERATION_ERROR(state, error) {
        state.error = error;
    },
    OPERATION_PAY(state, data) {
        state.error = null;
        state.status = data;
    },
}

const actions = {
    async getOperations({ commit }) {
        const { data, error} = await getOperations();
        if(data){
            commit("SET_OPERATIONS", data)
        }else{
            commit("OPERATION_ERROR", error);
        }
    },
    async operationPay({ commit }, amount) {
        const { data, error} = await operationPay(amount);
        if(data){
            commit("OPERATION_PAY", data)
        }else{
            commit("OPERATION_ERROR", error);
        }
    },
}

const getters = {
    operations: (state) => state.operations.sort( (a, b) => Date.parse(b.tsform) - Date.parse(a.tsform) ),
    error: (state) => state.error,
}

const state = () => ({
    error: '',
    operations: [],
    status: ''
})

export default {
    mutations,
    getters,
    actions,
    state,
}