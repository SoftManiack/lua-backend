<template>
    <b-navbar
        class="navbar"
        fixed="top"
    >
        <b-collapse id="nav-collapse" is-nav>
            <b-navbar-nav class="ml-auto">
                <b-button :to="{ name: 'Logout' }">
                    <i class="fas fa-door-open"></i>
                </b-button>
            </b-navbar-nav>
        </b-collapse>
    </b-navbar>
</template>

<script>
export default {
    name: "Navbar",
    date() {
        return {};
    },
};
</script>

<style lang="scss">
    .navbar{
        height: 65px;
        background: #2F3843;
        border-bottom: 2px solid black;

    }
</style>
