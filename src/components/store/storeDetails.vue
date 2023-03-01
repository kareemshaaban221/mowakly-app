<template>
  <section class="storeDetails mt-5 mb-5">
    <!-- logo -->
    <div class="storeImage d-flex justify-content-center align-items-center">
        <img :src="store.icon" alt="store image">
    </div>
    <!-- name  -->
    <h3 class="text-center mt-3"> {{ store.name }} </h3>

    <!-- follow  -->
    <div class="follow_store">


        <button class="btn  d-flex align-items-center" v-if="store.is_followed==false"   @click="followStore()">
            <i class="fa-regular fa-bell" ></i>
            <span> {{ $t('store.follow') }} </span>
        </button>


        <button class="btn  d-flex align-items-center followActive"  v-if="store.is_followed==true" @click="followStore()">
            <i class="fa-regular fa-bell" ></i>
            <span > {{ $t('store.followed') }} </span>
        </button>


    </div>


    <!-- store information  -->
    <div class="row mt-5">

        <div class="col-md-6 mb-3">
            <div class="store_box">
                <h6 class="labeledSection"> {{ $t('store.desc') }} </h6>
                <p>
                    {{ store.bio }}
                </p>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="store_box">
                <h6 class="labeledSection"> {{ $t('store.branches') }} </h6>

                <!-- single branch  -->
                <div class="single_branch mt-3 mb-3 d-flex justify-content-between align-items-center" v-for="branch in branches" :key="branch.id">

                    <div class="d-flex align-items-center">

                        <img :src="branch.icon" alt="" class="flagImage">
                        <div>
                            <h6 v-text="branch.address"></h6>
                            <!-- <span class="text-muted">شارع الصندزق الاسود</span> -->
                        </div>
                    </div>

                    <button
                        class="btn p-0"
                        type="button"  data-bs-toggle="modal" :data-bs-target="'#exampleModal'+branch.id"
                    >
                            <img :src="loca" alt="" class="locationImage">
                    </button>

                    <!-- Modal -->
                    <div class="modal fade" :id="'exampleModal'+branch.id" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" style="min-width:80%">
                        <div class="modal-content">
                        
                        <div class="modal-body">

                            <div class="d-flex justify-content-end mb-3 mt-3">
                                <button class="btn btn-danger" data-bs-dismiss="modal"> 
                                    <i class="fa-solid fa-x"></i>
                                </button>
                            </div>

                            <!-- google map  -->
                            <GoogleMap
                                api-key="AIzaSyB4d19CAL7u_hJ8k4P7EaQFcnner_Q9KEo"
                                style="width: 100%; height: 500px"
                                :center="center"
                                :zoom="15"
                            >
                                <Marker
                                    :options="markerOptions"
                                />
                            </GoogleMap>
                        </div>

                        
                        </div>
                    </div>
                    </div>



                </div>

            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="store_box">
                <h6 class="labeledSection">  {{ $t('store.storeLinks') }} </h6>

                <div class="storeLinks mt-3 mb-3 d-flex justify-content-between">
                    <div class="site_social_media d-flex justify-content-around mt-3 mb-3">
                        <div v-for="soical in socials" :key="soical.id">
                            <a :href="soical.link">
                                <img :src="soical.image" :alt="soical.name">
                            </a>
                        </div>
                </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="store_box">
                <h6 class="labeledSection"> {{ $t('store.socialMedia') }} </h6>

                <div class="contact_sites d-flex align-items-center mt-3">
                    <img :src="phone" alt="">
                    <a :href="'tel:'+store.phone"> {{ $t('store.phone') }} : {{ store.phone }} </a>
                </div>

                
            </div>
        </div>
    </div>

    <!-- parts  -->
    <section class="parts">
        <h4 class="labeledSection"> {{ $t('store.parts') }} </h4> 

        <div class="row mt-5">

            <div class="col-md-6 mb-3" v-for="cat in cats" :key="cat.id">
                <div class="single_part">
                    <router-link :to="'/storeCategories/'+cat.id" @click="sendStoreId()">
                        <img :src="cat.image" alt="">

                        <h5 class=""> {{ cat.name }} </h5>
                    </router-link>
                </div>
            </div>
        </div>

    </section>
  </section>
</template>

<script>

import axios from 'axios'
import { GoogleMap, Marker } from 'vue3-google-map';

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

            // store object 
            store : {},
            // socail array 
            socials : [],
            cats : [],
            branches : [],

            dialog:false,
            center: { lat: 45.508, lng: -73.587 },
            markerOptions : { }

        }
    },
    methods:{
        async followStore(){
            // this.followActive = true

            await axios.post(`follow-store`,{
                store_id : this.$route.params.id
            })
            .then( (res)=>{
                if( res.data.code == 200 && res.data.key == 'success' ){
                    this.followActive = res.data.data.is_followed;
                    location.reload()
                }
            } )
        },


        // get store details 
        async getStoreDetails(){
            await axios.get(`single-store?lat=${localStorage.getItem('lat')}&long=${localStorage.getItem('lng')}&store_id=${this.$route.params.id}`)
            .then( (res)=>{
                this.store = res.data.data.store
                this.socials = res.data.data.store.socials
                this.cats = res.data.data.store.menu_categories
                this.branches = res.data.data.store.branches

                        
                for( let i = 0 ; i < this.branches.length ; i++ ){
                    this.center.lat = parseFloat(this.branches[i].lat)
                    this.center.lng = parseFloat(this.branches[i].long)

                    console.log(this.center.lat)
                    console.log(this.center.lng)
                    // console.log(this.center.lng)
                }
            } )
        },
        sendStoreId(){
            localStorage.setItem('store_id', this.$route.params.id)
        }

    },
    mounted(){
        this.getStoreDetails()

        this.markerOptions = {position: this.center, label: 'L', title: 'LADY LIBERTY' }

    },
    components:{
        GoogleMap, Marker
    },
    // setup() {
    //   const center = []
    //   const markerOptions = { position: center, label: 'L', title: 'LADY LIBERTY' }
    //   console.log(center)
    //   return { center, markerOptions }

      
    // },
}
</script>
 
<style lang="scss">
    $base-color: #1ec2a8;
    .storeDetails{
        position: relative;
        width:60%;
        margin:auto;
        .storeImage{
            img{
                width: 200px;
                height:140px;
                object-fit: cover;
            }
        }
        .follow_store{
            position: absolute;
            top: 20px;
            left:27px;
            svg, span{
                font-size: 22px;
                font-weight: 600;
                margin:0 5px;
            }
            button.followActive{
                color:#1ec2a8 !important;
            }
        }
        .store_box{
            box-shadow: 0px 0px 10px rgba(51, 51, 51, 0.123);
            border-radius: 6px;
            padding: 5px 10px;
            min-height: 130px;
            max-height: 180px;
            overflow-y: auto;
        }
        .locationImage{
            width:15px;
        }
        .flagImage{
            width: 12px;
            height: 19px;
            margin: 0 4px;
        }
        .storeLinks{
            p{ color:#111; font-weight: 600; }
            a{
                color:#111;
                text-decoration: underline !important;
                font-weight: 600;
            }
        }
        .contact_sites{
            img{
                width: 17px;
                margin: 0 7px;
            }
            a{
                color:#333;
            }
        }
        .single_part{
            position: relative;
            width: 87%;
            height: 300px;
            img{
                position: absolute;
                width:100%;
                height:100%;
                top: 0;
                left:0;
                filter:brightness(.5);
                border-radius: 10px;
            }
            h5{
                transition: .3s all;
                position: absolute;
                top: -9%;
                color: #fff;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 31px;
                font-weight: 600;
            }
            &:hover h5{
                top: 50%;
            }
        }
    }

    .site_social_media img{
        width:30px;
        height:30px;
        border-radius: 50%;
    }
</style>