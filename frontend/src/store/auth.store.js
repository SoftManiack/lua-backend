import { loginKYC } from '@/services/kyc.service';

const mutations = {
    AUTH_SET_TOKEN(state, token) {
        localStorage.setItem('token', token);
        state.status = "Authorization"
    },
    LOGIN_ERROR(state, error) {
        state.error = error;
    },
    LOGOUT(state) {
        localStorage.removeItem('token')
        state.status = 'NoAuthorization';
    },
}

const actions = {
    login({ commit }) {
        try {
            loginKYC()
        } catch (error) {
            commit('LOGIN_ERROR', error);
        }
    },
    setToken({ commit }, token) {
        commit('AUTH_SET_TOKEN', token)
    },
    logout({ commit }) {
        commit('LOGOUT')
    },
}

const getters = {
    isAuthorisation: (state) => state.token,
    errorAuthorisation: (state) => state.error,
}

const state = () => ({
    error: '',
    token: localStorage.getItem('token') || '',
    status: ''
})

export default {
    mutations,
    getters,
    actions,
    state,
}
