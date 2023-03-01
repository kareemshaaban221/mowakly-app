<template>
    <!-- loader  -->
    <loader v-if="loader" />
    <!-- header -->
    <pageHeader />

    <!-- filtered store  -->
    <filteredStore :ads="ads" :menu_category="menu_category" :store="store" :storeImage="storeImage" />

    <!-- footer -->
    <pageFooter />
</template>

<script>
import pageHeader from '../components/home/pageHeader.vue'
import pageFooter from '../components/home/pageFooter.vue'
import filteredStore from '../components/store/filteredStore.vue'
import loader from '../components/share/pageLoader.vue'

import axios from 'axios'
export default {
    components:{
        pageHeader,
        pageFooter,
        filteredStore,
        loader
    },
    data(){
        return{
            loader : true,
            storeImage : '',
            store : '',
            menu_category : '',
            ads : []

        }
    },
    methods:{
        async getStoreAds(){
            await axios.get(`store-ads?menu_category=${this.$route.params.id}&store_id=${localStorage.getItem('store_id')}`)
            .then((res)=>{
                if(localStorage.getItem('store_id')){
                    this.storeImage = res.data.data.icon 

                    this.store = res.data.data.store;
                    this.menu_category = res.data.data.menu_category

                    this.ads = res.data.data.ads

                    this.loader = false

                    
                }
            })
        }
    },
    mounted(){
        this.getStoreAds()
    }
}
</script>

<style>

</style>