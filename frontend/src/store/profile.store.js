import { getProfile } from '@/services/profile.service';

const mutations = {
    SET_PROFILE(state, profile) {
        state.profile = profile;
    },
    PROFILE_ERROR(state, error) {
        state.error = error;
    },
}

const actions = {
    async getProfile({ commit }) {
        const { data, error } = await getProfile();
        if(data){
            commit("SET_PROFILE", data)
        }else{
            commit("PROFILE_ERROR", error);
        }
    },
}

const getters = {
    profile: (state) => state.profile,
}

const state = () => ({
    error: '',
    profile: {
        tariff: {},
        client: {},
        balance: {},
        tariffResources: {},
        clientResources: {}
    },
    status: ''
})

export default {
    mutations,
    getters,
    actions,
    state,
}