<template>
    <swiper
        :spaceBetween="30"
        :centeredSlides="true"
        :effect="'fade'"
        :autoplay="{
        delay: 3500,
        disableOnInteraction: false,
        }"
        :pagination="{
        clickable: true,
        }"
        :modules="modules"
        class="mySwiper"
    >
        <swiper-slide v-for="slider in sliders" :key="slider">
            <img :src="slider.image" alt="slider image">
        </swiper-slide>

    <div class="overlay"></div>
  </swiper>
</template>

<script>
// Import Swiper Vue.js components
import { Swiper, SwiperSlide,  } from "swiper/vue";

// Import Swiper styles
import "swiper/css";
import "swiper/css/effect-fade";
import "swiper/css/pagination";

// import required modules
import { Autoplay, Pagination , EffectFade} from "swiper";

export default {
    data(){
        return{
            // sliders : [
            //     require('../../assets/slider1.jpg'),
            //     require('../../assets/slider2.jpeg'),
            //     require('../../assets/slider3.jpg'),

            // ]
        }
    },
    components: {
        Swiper,
        SwiperSlide,
    },
    setup() {
        return {
        modules: [Autoplay, Pagination , EffectFade],
        };
    },
    props:{
        sliders : Array
    }
}
</script>

<style lang="scss" scoped>
    $base-color: #1ec2a8;
    .swiper{
        height: 48vh;
        position: absolute;
        top: 0;
        right: 0;
        width: 100%;
        z-index: 0;
        img{
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .overlay{
            position: absolute;
            width: 100%;
            height: 100%;
            top:0;
            right:0;
            z-index: 1;
            background-color:rgb(109 151 145 / 60%);
        }

    }
</style>

<style>
        .swiper-pagination-bullet{
            width: 11px;
            height:11px;
            background-color: #dcdcdc;
            opacity: 1;
        }
        .swiper-pagination-bullet-active{
            background-color: #1ec2a8 !important;
        }
</style>