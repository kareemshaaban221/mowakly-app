<template>
    <!-- header -->
    <pageHeader />
        
    <!-- store details  -->
    <storeDetails />
    
    <!-- footer  -->
    <pageFooter />
</template>

<script>
import pageHeader from '../components/home/pageHeader.vue'
import pageFooter from '../components/home/pageFooter.vue'
import storeDetails from '../components/store/storeDetails.vue'
export default {
    components:{
        pageHeader,
        pageFooter,
        storeDetails
    }
}
</script>

<style>

</style>