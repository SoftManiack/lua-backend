<template>
    <div class="login">
        <b-container class="login_container container">
            <h4>Вход</h4>
            <hr/>
            <b-button @click="login" class="button">
                Войти через KYC
            </b-button>
        </b-container>
    </div>
</template>

<script>
import { mapActions } from "vuex";
export default {
    name: "Login",
    data() {
        return {
            loginForm: {},
        };
    },
    methods: {
        ...mapActions({
            loginKYC: "login",
        }),
        login() {
            this.loginKYC();
        },
    },
};

</script>

<style lang="scss">
    .login{
        margin: 0;
        padding-top: 25vh;
        width: 100%;

        &_container{
            width: 60%;
            height: 200px;
        }

    }
</style>
