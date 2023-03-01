<template>
    <!-- header  -->
    <pageHeader />

    <!-- all offers  -->
    <allOffers />

    <!-- footer  -->
    <pageFooter />
    
</template>

<script>
import pageHeader from '../components/home/pageHeader.vue';
import pageFooter from '../components/home/pageFooter.vue';
import allOffers from '../components/offers/allOffers.vue'
export default {
    components:{
        pageHeader,
        pageFooter,
        allOffers
    }
}
</script>

<style>

</style>