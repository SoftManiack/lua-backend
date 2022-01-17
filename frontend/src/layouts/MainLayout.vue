<template>
    <div>
        <Navbar/>
        <b-row class="main-layout" fluid>
            <b-col col lg="1" md="1" sm="2" xs="2">
                <div class="main-layout_navbar">
                    <router-link :to="{ name: 'Home' }"><i class="fas fa-home main-layout_icon"></i></router-link>
                    <router-link :to="{ name: 'Tariffs' }"><i class="fas fa-shopping-basket main-layout_icon"></i></router-link>
                    <router-link :to="{ name: 'Finance' }"><i class="fas fa-history main-layout_icon"></i></router-link>
                </div>
            </b-col>
            <b-col col lg="11" md="11" sm="10" xs="10">
                <router-view/>
            </b-col>
        </b-row>
    </div>
</template>

<script>
import Navbar from '@/components/Navbar.vue'

export default {
    name: "MainLayout",
    components: {
        Navbar: Navbar
    }
}
</script>

<style lang="scss">
    .main-layout{
        margin-top: 65px;
        width: 100%;

        &_navbar{
            position: fixed;
            min-height: 93.2vh;
            width: 60px;
            background-color: #2F3843;
        }

        &_icon{

            margin: 21%;
            font-size: 1.8rem;
            color: #bdcee5;
            cursor: pointer;
        }

        &_icon:hover{
            transition: all 0.6s;
            color: #61DDE4;
        }

    }
</style>
