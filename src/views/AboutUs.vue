<template>
    <!-- loader  -->
    <loader v-if="loader" />
    <!-- header  -->
    <pageHeader />

    <!-- about head  -->
    <aboutHead :whous="whous" />

    <!-- about statistics  -->
    <aboutStatis :stores="stores" :downloads="downloads" :clients="clients" />

    <!-- download app  -->
    <aboutDownload :android="android" :ios="ios" />

    <!-- footer  -->
    <pageFooter />
</template>

<script>
import pageHeader from '../components/home/pageHeader.vue'
import pageFooter from '../components/home/pageFooter.vue'
import aboutHead from '../components/about/aboutHead.vue';
import aboutStatis from '../components/about/aboutStatistics.vue';
import aboutDownload from '../components/about/downloadApp.vue';

import loader from  '../components/share/pageLoader.vue'

import axios from 'axios'
export default {
    data(){
        return{
            whous : '',
            clients : 0,
            downloads : 0,
            stores : 0,
            loader : true

        }
    },
    components:{
        pageHeader,
        pageFooter,
        aboutHead,
        aboutStatis,
        aboutDownload,
        loader
    },
    methods:{
        async getWhoUs(){
            await axios.get('whous')
            .then( (res)=>{
                this.whous = res.data.data.whous
            } )
        },
        async getStatistics(){
            await axios.get('web-info')
            .then( (res)=>{
                this.clients = res.data.data.clients
                this.downloads = res.data.data.downloads
                this.stores = res.data.data.stores

                this.android = res.data.data.ios_link
                this.ios = res.data.data.android_link

                this.loader = false
            } )
        },
    },
    mounted(){
        this.getWhoUs()
        this.getStatistics()
    }
}
</script>

<style>

</style>