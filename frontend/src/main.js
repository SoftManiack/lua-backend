import Vue from 'vue';
import App from '@/App.vue';
import router from '@/router/index';
import store from '@/store/index';
import { Vuelidate } from 'vuelidate'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import '../public/styles/custom.scss'
import '@fortawesome/fontawesome-free/css/all.css'
import '@fortawesome/fontawesome-free/js/all.js'

import { BootstrapVue, BootstrapVueIcons } from 'bootstrap-vue';

Vue.config.productionTip = false;

new Vue({
    render: h => h(App),
    store,
    router,
}).$mount('#app');

Vue.use(Vuelidate);
Vue.use(BootstrapVue, BootstrapVueIcons);

