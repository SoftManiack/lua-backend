import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '@/store/index.js'

import Login from '@/views/Login.vue'
import Error404 from '@/views/404.vue'
import Finance from "@/views/Finance"
import Home from "@/views/Home"
import Tariffs from "@/views/Tariffs"
import Pay from "@/views/Pay"

Vue.use(VueRouter);

const routes = [
    {
        path: '/login',
        name: 'Login',
        component: Login,
        meta: { layout: "EmptyLayout", requiresAuth: false }
    },
    {
        path: '/logout',
        name: 'Logout',
        component: Login,
        meta: { layout: "EmptyLayout", requiresAuth: false }
    },
    {
        path: '/',
        name: 'Home',
        component: Home,
        meta: { layout: "MainLayout", requiresAuth: true }
    },
    {
        path: '/finance',
        name: 'Finance',
        component: Finance,
        meta: { layout: "MainLayout", requiresAuth: true }
    },
    {
        path: '/tariffs',
        name: 'Tariffs',
        component: Tariffs,
        meta: { layout: "MainLayout", requiresAuth: true }
    },
    {
        path: '/pay',
        name: 'Pay',
        component: Pay,
        meta: { layout: "EmptyLayout", requiresAuth: true }
    },
    {
        path: '*',
        name: 'Error404',
        component: Error404,
        meta: { layout: "EmptyLayout", requiresAuth: true }
    },
]

const router = new VueRouter({
    mode: 'history',
    routes,
})

router.beforeEach((to, from, next) => {

    if (to?.fullPath === '/logout') {
        store.dispatch('logout');
    }

    //Protection to routes and extract token
    if (to.matched.some(record => record.meta.requiresAuth)) {

        const urlParams = new URLSearchParams(window.location.search);
        const token = urlParams.get('access_token');

        if (token) {
            store.dispatch('setToken', token);
            window.location.replace(to.path);
        }
        if (store.getters.isAuthorisation) {
            next()
        } else {
            next('/login')
        }

    }

    next();

})

export default router;
