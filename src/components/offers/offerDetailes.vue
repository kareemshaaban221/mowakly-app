<template>
  <div class="container mt-4">
    <div class="offer_details_header d-flex align-items-center justify-content-between">
      <h1 class="fontBold font20"> {{ ad.name }} </h1>
      <span class="mainColor2">{{ $t('offers.additionDate') }}  : {{ ad.created_at }} </span>
    </div>
    <div class="menu_category d-flex align-items-center justify-content-end">
      <!-- <h2 class="fontBold font15">إسم المتجر</h2> -->
      <span class="mainColor2"> {{ ad.menu_category }} </span>
    </div>
    <div class="categories">
      <span class="catrgItem" v-for="tag in tags" :key="tag.id" >{{ tag.name }}</span>
    </div>
    <div class="row mb-4">
      <div class="col-lg-6 col-12">

        <!-- offer sliders images  -->
        <offerDetailesSlider v-if="offerDetialsImages" :offerDetialsImages="offerDetialsImages" :adId="adId" :is_favorite="is_favorite" />

      </div>
      <div class="col-lg-6 col-12">
        <div class="d-flex flex-column gap20">
          <h3 class="fontBold">{{ $t('offers.AdDescription') }}</h3>
          <p>
            {{ ad.desc }}
          </p>
        </div>
      </div>
    </div>


    <!-- similar_ads  -->
    <div class="row mb-4">
      <div class="col-12 mb-3">
        <h5 class="labeledSection fw-bold">{{ $t('offers.Similar') }}</h5>
      </div>

      <!-- single ad  -->
      <div class="col-lg-4 col-md-6 col-12 mb-3" v-for="similar in similar_ads" :key="similar.id">
        <!-- single new offer  -->
        <router-link :to="'/OfferDescription/'+similar.id">
          <div class="singleNewOffer">
            <!-- offer image  -->
            <img :src="similar.image" alt="new offer image" class="newOfferImage" />

            <!-- store name -->
            <div class="storeName">
              <h5> {{ similar.store_name }} </h5>
              <h6> {{ similar.name }} </h6>
            </div>

            <!-- time -->
            <span class="offerTime"> {{ similar.created_at }} </span>

            <!-- category  -->
            <span class="offerCate"> {{ similar.menu_name }} </span>
          </div>
        </router-link>
      </div>


    </div>
  </div>
</template>

<script>

import offerDetailesSlider from "@/components/offers/offerDetailesSlider.vue";

import axios from 'axios'

export default {
  data() {
    return {
      src: require("../../assets/slider1.jpg"),
      ad : {},
      tags : [],
      offerDetialsImages : [],
      is_favorite :false ,
      similar_ads : [],
      adId : 0
    };
  },
  components: {
    offerDetailesSlider,
  },

  methods:{
    async adsDetails(){
      await axios.get(`single-ad?ad_id=${this.$route.params.id}&mac_address=${localStorage.getItem('macAddress')}`)
      .then( (res)=>{
        this.ad = res.data.data.ad
        this.tags = res.data.data.ad.tags
        this.offerDetialsImages = res.data.data.ad.images
        this.is_favorite = res.data.data.ad.is_favorite
        this.similar_ads = res.data.data.ad.similar_ads
        this.adId = res.data.data.ad.id



      } )
    }
  },
  mounted(){
    this.adsDetails()
                console.log(this.is_favorite);

  },

};
</script>

<style lang="scss" scoped>
$mainColor2: #807f7f;

.mainColor2 {
  color: $mainColor2;
}
.categories {
  margin: 25px 0;
  .catrgItem {
    padding: 5px 15px;
    background-color: #eee;
    color: $mainColor2;
    font-size: 18px;
    border-radius: 5px;
    box-shadow: 0 0 5px rgb(241, 241, 241);
  }
}
.categories .catrgItem{
  margin-left: 12px;
}
@media( max-width:768px ){
    .menu_category{
      justify-content: center !important;
    }
}
</style>
