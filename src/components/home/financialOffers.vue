<template>
    <div class="container mt-5">
         <swiper
            :slidesPerView="3"
            :spaceBetween="12"
            :pagination="{
            clickable: true,
            }"
            :autoplay="{
                delay: 2500,
                disableOnInteraction: false,
            }"
            :modules="modules"
            class="mySwiper mt-4"
        >

            <swiper-slide  class="swiperSlide" v-for="offer in paid_ads" :key="offer.id">
                <router-link :to="'/OfferDescription/'+offer.id">
                    <!-- single new offer  -->
                    <div class="singleNewOffer">

                        <!-- offer image  -->
                        <img :src="offer.src" alt="new offer image" class="newOfferImage">

                        <!-- store name -->
                        <div class="storeName">
                            <h5>{{ offer.store_name }}</h5>
                            <h6> {{ offer.name }} </h6>
                        </div>

                        <!-- time -->
                        <span class="offerTime"> {{ offer.created_at }} </span>

                        <!-- category  -->
                        <span class="offerCate"> {{ offer.menu_name }} </span>

                    </div>
                </router-link>
            </swiper-slide>
        </swiper>

    </div>
</template>

<script>
// Import Swiper Vue.js components
import { Swiper, SwiperSlide } from "swiper/vue";

// Import Swiper styles
import "swiper/css";

import "swiper/css/pagination";


// import required modules
import { Autoplay ,Pagination } from "swiper";

export default {
    data(){
        return{
            // src : require('../../assets/slider1.jpg'),

        }
    },
    components: {
        Swiper,
        SwiperSlide,
    },
    setup() {
        return {
            modules: [Pagination, Autoplay],
        };
    },
    props : {
        paid_ads : Array
    }
}
</script>

<style lang="scss" scoped>
    $base-color: #1ec2a8;
    .swiper{
        padding-bottom:50px;
        // .swiperSlide{
        //     position: relative;
        //     width: 175px !important;
        //     height: 92px;
        //     border-radius: 20px;
        // }

        .swiper-pagination-bullet{
            width: 11px;
            height:11px;
            background-color: #dcdcdc;
            opacity: 1;
        }
        .swiper-pagination-bullet-active{
            background-color: #1ec2a8 !important;
        }
    }
    .swiper-horizontal>.swiper-pagination-bullets, .swiper-pagination-bullets.swiper-pagination-horizontal{ bottom: 0; }
</style>