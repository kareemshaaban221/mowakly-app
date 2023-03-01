<template>
  <div class="container mt-4">
    <div class="d-flex justify-content-between">
        <h5 class="labeledSection fw-bold"> {{ $t('home.offers') }} </h5>

        <router-link to="/" >
            <h6 class="allStores"> {{ $t('home.allOffers') }} </h6>
        </router-link>
    </div>

    <section class="mt-4">
        <div class="row">
            <div class="col-md-4" v-for="offer in ads" :key="offer.id">
                <!-- single new offer  -->
                <router-link :to="'/OfferDescription/'+offer.id">
                    <div class="singleNewOffer">

                        <!-- offer image  -->
                        <img :src="offer.src" alt="new offer image" class="newOfferImage">

                        <!-- store name -->
                        <div class="storeName">
                            <h5> {{ offer.store_name }} </h5>
                            <h6>{{ offer.name }}</h6>
                        </div>

                        <!-- time -->
                        <span class="offerTime">{{ offer.created_at }}</span>

                        <!-- category  -->
                        <span class="offerCate"> {{ offer.menu_name }} </span>

                    </div>
                </router-link>
            </div>
        </div>  
    </section>
  </div>
</template>

<script>
export default {
    data(){
        return{
            src : require('../../assets/slider1.jpg'),

        }
    },
    props:{
        ads : Array
    }
}
</script>

<style>

</style>