<template>
    <div class="login-warapper">
        <div class="log-title"><h1>{{ titleAuth }}</h1></div>
    </div>
</template>

<script>
    export default{
        props: {
            titleAuth: String
        },
    }
</script>

<style lang="scss">

    .login-warapper{
        position: relative;
        height: 100%;
        background: url('../../assets/artem_podrez.png') no-repeat center;
        background-size: cover;
        img{
            width: 100%;
            height: 100%;
        }
        .log-title{
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(rgba(51, 51, 51, .50), rgba(51, 51, 51, .20));
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }
    }

</style>