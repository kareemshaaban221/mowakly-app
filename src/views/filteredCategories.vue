<template>
  <!-- header  -->
  <pageHeader />

  <!-- all stores  -->
  <allStores />

  <!-- footer  -->
  <pageFooter />
</template>

<script>
import pageHeader from '../components/home/pageHeader.vue';
import pageFooter from '../components/home/pageFooter.vue';

import allStores from '../components/store/AllStores.vue'
export default {
  components:{
    pageHeader,
    pageFooter,

    allStores
  }
}
</script>

<style>

</style>