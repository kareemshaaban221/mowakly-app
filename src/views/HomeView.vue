<template>
  <!-- loader  -->
  <PageLoader  v-if="loader"/> 

  <!-- header -->
  <pageHeader :sliders="sliders"/>

  <!-- parts  -->
  <HomeParts :categories="categories" />

  <!-- new offers  -->
  <newOffers :latest_ads="latest_ads" />

  <!-- financial offers  -->
  <financialOffers :paid_ads="paid_ads"/>

  <!-- famous stores  -->
  <famouseStores :stores="stores" />

  <!-- home offers  -->
  <homeOffers :ads="ads" />

  <!-- footer  -->
  <pageFooter />

  
</template>

<script>

import { defineComponent } from 'vue';
import pageHeader from '../components/home/pageHeader.vue';
import HomeParts from '../components/home/HomeParts.vue';
import newOffers from '../components/home/NewOffers.vue';
import financialOffers from '../components/home/financialOffers.vue';
import famouseStores from '../components/home/famousStores.vue';
import homeOffers from '../components/home/homeOffers.vue';
import pageFooter from '../components/home/pageFooter.vue'

import PageLoader from '../components/share/pageLoader.vue'


import axios from 'axios'


export default defineComponent({
  name: 'HomeView',
  data(){
    return{
      loader : true,
      sliders : [],
      latest_ads : [],
      paid_ads : [],
      categories : [],
      stores : [],
      ads :[],
      webData : {}
    }
  },
  mounted(){
    this.getHome()
  },

  components: {
    pageHeader,
    HomeParts,
    newOffers,
    financialOffers,
    famouseStores,
    homeOffers,
    pageFooter,
    PageLoader
  },
  methods:{
    async getHome(){
      await axios.get(`home?lat=${localStorage.getItem('lat')}&long=${localStorage.getItem('lng')}&mac_address=${localStorage.getItem('macAddress')}`, {
        headers : {
            Authorization:  `Bearer ${localStorage.getItem('token')}`
        }
      })
      .then( (res)=>{
        this.sliders = res.data.data.sliders;
        this.latest_ads = res.data.data.latest_ads;
        this.paid_ads = res.data.data.paid_ads;
        this.categories = res.data.data.categories;
        this.stores = res.data.data.stores;
        this.ads = res.data.data.ads;

        this.loader = false


      } )
      .catch( (err)=>{
        console.log( err )
      } )
    },






  },

});
</script>
