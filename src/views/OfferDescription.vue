<template>
    <!-- header  -->
    <pageHeader />

    <offerDetailes />

    <!-- footer  -->
    <pageFooter />
    
</template>

<script>
import pageHeader from '../components/home/pageHeader.vue';
import pageFooter from '../components/home/pageFooter.vue';
import offerDetailes from '../components/offers/offerDetailes.vue';


export default {
    components:{
        pageHeader,
        pageFooter,
        offerDetailes,
    }
}
</script>

<style>

</style>