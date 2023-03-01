<template>
    <div class="container mt-4">
        <h5 class="labeledSection fw-bold"> {{ $t('home.parts') }} </h5>
         <swiper
            :slidesPerView="6"
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

                <swiper-slide  class="swiperSlide" v-for="part in categories" :key="part.id">
                    <!-- <router-link :to="'/fileredcategories/'+part.id" > -->
                    <router-link :to="{ name: 'fileredcates', params: { id: part.id }, query: { slug: part.slug } }" >

                        <img :src="part.image" alt="">

                        <h6> {{ part.name }} </h6>
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
import {Autoplay, Pagination } from "swiper";

export default {
    data(){
        return{
            parts : [
                {
                    id:1,
                    partName : 'الكترونيات',
                    partImage : require('../../assets/slider1.jpg'),

                },
                 {
                    id : 2,
                    partName : 'الكترونيات',
                    partImage : require('../../assets/slider1.jpg'),

                },
                 {
                    id:3,
                    partName : 'الكترونيات',
                    partImage : require('../../assets/slider1.jpg'),

                },
                 {
                    id:4,
                    partName : 'الكترونيات',
                    partImage : require('../../assets/slider1.jpg'),

                },
                 {
                    id:5,
                    partName : 'الكترونيات',
                    partImage : require('../../assets/slider1.jpg'),

                },
                 {
                    id: 6,
                    partName : 'الكترونيات',
                    partImage : require('../../assets/slider1.jpg'),

                },
                 {
                    id:7,
                    partName : 'الكترونيات',
                    partImage : require('../../assets/slider1.jpg'),

                }
            ]
        }
    },
    components: {
        Swiper,
        SwiperSlide,
    },
    setup() {
        return {
            modules: [Autoplay , Pagination],
        };
    },
    props:{
        categories : Array
    },
    mounted(){


    }
}
</script>

<style lang="scss" scoped>
    $base-color: #1ec2a8;
    .swiper{
        padding-bottom:50px;
        .swiperSlide{
            position: relative;
            width: 175px !important;
            height: 92px;
            border-radius: 20px;
            img{
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 50px;
                filter: brightness(0.5);
            }
            h6{
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: #fff;
            }
        }

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

    @media( max-width:768px ){
        .swiper .swiperSlide{
            width:100px !important;
            height:60px
        }
        .swiper .swiperSlide h6{
            font-size: 12px;
        }
    }
</style>