<template>
    <!-- loader  -->
    <loader v-if="loader" />
    <!-- header  -->
    <pageHeader />

    <!-- favs  -->
    <allFavs   />

    <!-- footer -->
    <pageFooter />

</template>

<script>
import pageHeader from '../components/home/pageHeader.vue'
import pageFooter from '../components/home/pageFooter.vue'
import allFavs from '../components/favs/allFavs.vue';

export default {

    data(){
        return{

        }
    },
    components:{
        pageHeader,
        pageFooter,
        allFavs,
    },
    methods : {

    },
    mounted(){
    },
    computed : {
    token(){
      return this.$store.getters.getToken
    }
  }

}
</script>

<style>

</style>