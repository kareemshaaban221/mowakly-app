<template>


    <!-- header  -->
    <pageHeader />


    <notificationList  />

    <!-- footer  -->
    <pageFooter />
    
</template>

<script>

import pageHeader from '../components/home/pageHeader.vue';
import pageFooter from '../components/home/pageFooter.vue';
import notificationList from '../components/profile/notificationList.vue';

export default {
    data(){
        return{
            loader : true ,
            notiCount : null,
        }
    },
    components:{
        pageHeader,
        pageFooter,
        notificationList,
    },
    methods:{

    },
    beforeMount(){
        this.notiCount = localStorage.getItem('noticount')
    },
    mounted(){
        this.notiCount = 0    
    },

}
</script>

<style>

</style>