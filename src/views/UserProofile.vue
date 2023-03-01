<template>

    <loader v-if="loader" />

    <!-- header  -->
    <pageHeader />

    <!-- profile component  -->
    <profileCompo :FAQS="FAQS" :policy="policy" :aboutapp="aboutapp" :whous="whous" :terms="terms"  />

    <!-- footer  -->
    <pageFooter />
</template>

<script>
import pageHeader from '../components/home/pageHeader.vue';
import pageFooter from '../components/home/pageFooter.vue';
import profileCompo from '../components/profile/profileComponent.vue'
import loader from '../components/share/pageLoader.vue'


import axios from 'axios'
export default {
    components:{
        pageHeader,
        pageFooter,
        profileCompo,
        loader
    },

    data(){
        return{
            policy : '',
            terms : '',
            whous : '',
            aboutapp : '',
            FAQS : [],
            loader :true
        }
    },
    methods :{

        // get policy 
        async getPolicy(){
            await axios.get('policy')
            .then( (res)=>{
                if( res.data.code == 200 ){
                    this.policy = res.data.data.policy ;
                }
            } )
            .catch( (err)=>{
                console.log(err)
            } )
        },

        // get terms 
        async getTerms(){
            await axios.get('terms')
            .then( (res)=>{
                if( res.data.code == 200 ){
                    this.terms = res.data.data.terms ;
                }
            } )
            .catch( (err)=>{
                console.log(err)
            } )
        },

        // get whous 
        async getWhous(){
            await axios.get('whous')
            .then( (res)=>{
                if( res.data.code == 200 ){
                    this.whous = res.data.data.whous ;
                }
            } )
            .catch( (err)=>{
                console.log(err)
            } )
        },
        // get getAboutApp 
        async getAboutApp(){
            await axios.get('about-app')
            .then( (res)=>{
                if( res.data.code == 200 ){
                    this.aboutapp = res.data.data.aboutapp ;
                    console.log(this.aboutapp)
                }
            } )
            .catch( (err)=>{
                console.log(err)
            } )
        },


        // get FAQ 
        async getFAQ(){
            await axios.get('faqs')
            .then( (res)=>{
                if( res.data.code == 200 ){
                    this.FAQS = res.data.data.faqs ;
                    this.loader = false
                }
            } )
            .catch( (err)=>{
                console.log(err)
            } )
        },

    },
    mounted(){
        this.getPolicy()
        this.getTerms()
        this.getWhous()
        this.getAboutApp()
        this.getFAQ()
    }
}
</script>

<style>

</style>