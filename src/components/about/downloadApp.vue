<template>
    <section class="dowloadApp">
        <div class="container">
            <div class="row">


                <div class="col-md-6">
                    <div>
                        <h1 class="fw-bold mb-3">
                            {{ $t('common.downloadApp') }}
                        </h1>
<!-- 
                        <p class="text-muted">
                            Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ducimus porro nesciunt deleniti. Culpa velit voluptates, neque incidunt aspernatur deserunt. Reprehenderit officiis veniam, ea porro possimus rem non ratione temporibus fugiat.
                        </p> -->
                    </div>

                        <div class="downloadApp mt-3">
                            <div class="d-flex">
                                <a :href="ios">
                                    <img :src="appStore" alt="">
                                </a>

                                <a :href="android">
                                    <img :src="googlePlay" alt="">
                                </a>
                            </div>
                        </div>
                </div>

                <div class="col-md-6">
                    <div class="dowloadPhone d-flex justify-content-center align-items-center mx-auto">
                        <img :src="phoneImage" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import axios from 'axios'
export default {
    data(){
        return{
            googlePlay : require('../../assets/googlePlay.png'),
            appStore : require('../../assets/appStore.png'),
            phoneImage : require('../../assets/Body.png'),

            ios : '',
            android : ''
        }
    },

    methods:{
        async getStatistics(){
            await axios.get('web-info')
            .then( (res)=>{

                this.android = res.data.data.android_link
                this.ios = res.data.data.ios_link
            } )
        },
    },
    mounted(){
        this.getStatistics()
    }
}
</script>

<style lang="scss" scoped>
    .dowloadApp{
        margin-top: 100px;
        .dowloadPhone{
        width: 400px;
        height:400px;
        border-radius: 50%;
        background-color: #1ec2a8;
        img{
            width: 314px;
            height: 445px;
            object-fit: contain;
        }
    }
    }
</style>