<template>
    <div class="container">
        <section class="storeDetails mt-5 mb-5">
    <!-- logo -->
    <div class="storeImage d-flex justify-content-center align-items-center">
        <img :src="storeImage" alt="store image">
    </div>
    <!-- name  -->
    <h3 class="text-center mt-3"> {{ store }} </h3>

    <h5 class="text-center mt-3"> {{ menu_category }} </h5>

    <!-- follow  -->
    <!-- <div class="follow_store">
        <button class="btn  d-flex align-items-center" :class="{ followActive }" @click="followStore()">
            <i class="fa-regular fa-bell" ></i>
            <span >متابعة المتجر</span>
        </button>
    </div> -->

    </section>

    <!-- filter process  -->
    <!-- <section class="filter_process mt-3">
    <h6 class="">{{ $t('nav.storeDepend') }}</h6>

    <form>
        <v-row align="center">
            <v-col class="customCheck d-flex" cols="12" sm="3">
                <v-select :items="items" :label="$t('nav.governorate')" solo></v-select>

                <img :src="flag" alt="" />
            </v-col>

            <v-col class="customCheck d-flex" cols="12" sm="3">
                <v-select :items="items" :label="$t('nav.city')" solo></v-select>

                <img :src="flag" alt="" />
            </v-col>

            <div class="checks d-flex">
                <v-checkbox
                v-model="current"
                color="info"
                :label="$t('nav.new')"
                class="shrink mr-2 mt-0"
                ></v-checkbox>

                <v-checkbox
                v-model="old"
                color="info"
                :label="$t('nav.old')"
                class="shrink mr-2 mt-0"
                ></v-checkbox>

                <v-checkbox
                v-model="nearest"
                color="info"
                :label="$t('nav.near')"
                class="shrink mr-2 mt-0"
                ></v-checkbox>
            </div>
        </v-row>
    </form>

    </section> -->

    
    <!-- filtered offers  -->
    <section class="filtered_offers" v-if="ads.length>0">
    <div class="row">
        <div class="col-md-4" v-for="ad in ads" :key="ad.id">
            <!-- single new offer  -->
            <router-link :to="'/OfferDescription/'+ad.id">


            <v-lazy
                v-model="isActive"
                :options="{
                threshold: .5
                }"
                min-height="200"
                transition="scroll-y-transition"
            >
                <div class="singleNewOffer">

                    <!-- offer image  -->
                    <img :src="ad.image" alt="new offer image" class="newOfferImage">

                    <!-- store name -->
                    <div class="storeName">
                        <h5>{{ ad.store_name }}</h5>
                        <h6> {{ ad.name }} </h6>
                    </div>

                    <!-- time -->
                    <span class="offerTime"> {{ ad.created_at }} </span>

                    <!-- category  -->
                    <span class="offerCate"> {{ ad.menu_name }} </span>

                </div>
            </v-lazy>
                
            </router-link>
        </div>
    </div>
    </section>

    <section v-else>
        <v-alert
            type="info"
            class="noFound"
            >
            {{ $t('common.notFound') }}
        </v-alert>
    </section>
    </div>
</template>

<script>
export default {
    data(){
        return{
            src:require('../../assets/logo2.png'),
            flag : require('../../assets/flag.png'),
            loca : require('../../assets/location.png'),
            phone : require('../../assets/phone.png'),
            face : require('../../assets/facebook.png'),
            src1 : require('../../assets/slider1.jpg'),
            followActive : false,
            // src : require('../../assets/slider1.jpg'),
            // flag: require("../../assets/flag.png"),
            current: false,
            old: false,
            nearest: false,
            isActive : false,




        }
    },
    props:{
        ads : Array,
        menu_category : String,
        store : String,
        storeImage : String
    },
    mounted(){
        console.log(this.ads)
    }
    

}
</script>

<style>

</style>