import Vue from 'vue'
import Vuex from 'vuex'
import auth from "@/store/auth.store"
import profile from "@/store/profile.store"
import tariff from "@/store/tariff.store"
import operation from "@/store/operation.store"

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {
        auth,
        profile,
        tariff,
        operation
    }
})
