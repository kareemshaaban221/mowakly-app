<template>
  <Carousel
    id="gallery"
    :items-to-show="1"
    :wrap-around="false"
    v-model="currentSlide"
    v-if="offerDetialsImages"
  >
    <Slide v-for="img in offerDetialsImages" :key="img.id">
      <div class="carousel__item">
        <div class="item-option">
          <v-btn icon="mdi-share-variant" color="main" @click="copyUrl()"></v-btn>

          <v-btn icon="mdi-heart" class="addToFav" :class="[{adFav : adFav},{is_favorite:is_favorite}]" color="main" @click="addToFav()"></v-btn>

        </div>
        <img :src="img.image" alt="" />
      </div>
    </Slide>
  </Carousel>


  <Carousel
    id="thumbnails"
    :items-to-show="5"
    :wrap-around="true"
    v-model="currentSlide"
    ref="carousel"
    v-if="offerDetialsImages"
  >
    <Slide v-for="img in offerDetialsImages" :key="img.id">
      <div class="carousel__item" @click="slideTo(img.id - 1)">
        <img :src="img.image" alt="" />
      </div>
    </Slide>
    <template #addons v-if="offerDetialsImages">
      <Navigation />
    </template>
  </Carousel>
</template>

<script>
import { defineComponent } from "vue";
import { Carousel, Navigation, Slide } from "vue3-carousel";
import "vue3-carousel/dist/carousel.css";
import axios from 'axios'

export default defineComponent({
  components: {
    Carousel,
    Slide,
    Navigation,
  },

  data: () => ({
    currentSlide: 0,
    adFav : null,
    
  }),
  methods: {

    copyUrl(){
      var element = window.location;
       navigator.clipboard.writeText(element);      

      this.$swal({
          icon: 'success',
          title: this.$t('common.copyUrl'),
          timer: 2000,
          showConfirmButton: false,
      });
    },
    slideTo(val) {
      this.currentSlide = val;
    },

    async addToFav(){

      const fd = new FormData()
      fd.append('ad_id',this.adId)
      fd.append('mac_address',localStorage.getItem('macAddress'))
      
      await axios.post(`add-to-fav`,fd)
      .then( (res)=>{
        if( res.data.code == 200 && res.data.key == "success" ){
          this.adFav = true;
          // this.is_favorite = true
          this.$swal({
              icon: 'success',
              title: res.data.msg,
              timer: 2000,
              showConfirmButton: false,
          });
        }else{
          this.$swal({
              icon: 'error',
              title: res.data.msg,
              timer: 2000,
              showConfirmButton: false,
          });
        }
      } )
      .catch( (err)=>{
        console.error(err)
      } )
    }

  },
  props : {
    offerDetialsImages : Array,
    is_favorite : Boolean,
    adId : Number
  },
  mounted(){
    console.log(this.is_favorite);
  }
});
</script>

<style lang="scss">
$mainColor2: #807f7f;
$mainColor: #1ec2a8;

.carousel__item {
  height: 400px;
  width: 100%;
  color: #fff;
  font-size: 20px;
  border-radius: 8px;
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
  margin: 5px;
  img {
    width: 100%;
    border-radius: 5px;
    height: 100%;
    object-fit: contain;
  }
}

#thumbnails .carousel__item {
  height: 100px;
  cursor: pointer;
}
.carousel__prev,
.carousel__next {
  background-color: #fff !important;
  border: 1px solid $mainColor !important;
  color: $mainColor !important;
  border-radius: 5px !important;
}
.item-option {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  padding: 20px;
  position: absolute;
  top: 0;
  right: 0;
}

.addToFav.adFav{
  color:red !important
}
.addToFav.is_favorite{
  color:red !important

}
</style>
