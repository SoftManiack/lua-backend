<template>
    <div id="app">
        <component :is="layout">
            <transition name="fade">
                <router-view />
            </transition>
        </component>
    </div>
</template>

<script>
import { mapActions } from "vuex";

export default {
    name: "App",
    components: {
        MainLayout: () => import("@/layouts/MainLayout"),
        EmptyLayout: () => import("@/layouts/EmptyLayout"),
    },
    computed: {
        layout() {
            return this.$route.meta.layout || "EmptyLayout";
        },
    },
    methods: {
        ...mapActions({
            getProfile: "getProfile"
        }),
    },
    mounted() {
        this.getProfile();
    },
};
</script>

<style lang="scss">

</style>
