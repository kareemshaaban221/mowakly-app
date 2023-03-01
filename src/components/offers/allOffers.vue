<template>

    <!-- loader  -->
    <loader v-if="loader" />

  <section id="offers" class="mt-4" v-if="ads.length>0">
    <div class="container">
        <h5 class="labeledSection fw-bold"> {{ $t('nav.offers') }} </h5>

        <!-- filter process  -->
        <section class="filter_process mt-3">
            <h6 class="">{{ $t('nav.storeDepend') }}</h6>

                <v-row align="center">
                    <v-col class="customCheck d-flex" cols="12" sm="3">
                        <!-- المحافظة  -->
                        <div class="position-relative w-100">
                            <input type="text" v-model="regionQuery"  name="query" :placeholder="$t('nav.governorate')" class="form-control searchBox" @input="getRegions()">
                            <i class="fa-solid fa-angle-down"></i>
                        </div>

                        <div v-if="showList1" style="position:absolute;width:95%;height:200px;overflow-y:auto;top:50px;z-index:999">
                            <ul class="list-group" style="z-index:9999" v-if="filteredRegions.length>0">
                                <li class="list-group-item" v-for="(item,index) in filteredRegions" :key="item.id" >
                                        <span @click="setNewValueForRegion(item.name, item.id)" style="cursor:pointer" >
                                            {{index+1}}.{{item.name}}
                                        </span>
                                </li>
                                <li class="list-group-item">
                                    <button @click.prevent="loadMore1" > {{ $t('common.loadMore') }} </button>
                                </li>
                            </ul>
                            <ul class="list-group" v-else>
                                <li class="list-group-item"> {{ $t('common.noData') }} </li>
                            </ul>
                        </div>

                        <img :src="flag" alt="" />
                    </v-col>

                    <v-col class="customCheck d-flex flex-column position-relative" cols="12" sm="3">
                        <!-- المدينة  -->

     
                        <div class="position-relative w-100">
                            <input type="text" v-model="query"  name="query" :placeholder="$t('nav.city')" class="form-control searchBox" @input="getData()">
                            <i class="fa-solid fa-angle-down"></i>
                        </div>

                        <div v-if="showList" style="position:absolute;width:95%;max-height:200px;top:50px;z-index:999;overflow-y:auto;">
                            <ul class="list-group" style="z-index:9999" v-if="filteredCities.length>0">
                                <li class="list-group-item" v-for="(item,index) in filteredCities" :key="item.id" >
                                        <span @click="setNewValue(item.name, item.id)" style="cursor:pointer" >
                                            {{index+1}}.{{item.name}}
                                        </span>
                                </li>

                                <li class="list-group-item">
                                    <button @click.prevent="loadMore" > {{ $t('common.loadMore') }} </button>
                                </li>
                            </ul>
                            <ul class="list-group" v-else>
                                <li class="list-group-item"> {{ $t('common.noData') }} </li>
                            </ul>
                        </div>
                            
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

        </section>

        <!-- filtered offers  -->
        <section class="filtered_offers mt-4">
            <div class="row">
                <div class="col-md-4 mb-3" v-for="ad in ads" :key="ad.id">
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
                                <h5>{{  ad.store_name}}</h5>
                                <h6>{{ ad.name }}</h6>
                            </div>

                            <!-- time -->
                            <span class="offerTime">{{ ad.created_at }}</span>

                            <!-- category  -->
                            <span class="offerCate"> {{ ad.menu_name }} </span>

                        </div>
                    </v-lazy>
                        
                    </router-link>
                </div>
            </div>
        </section>



            <paginate
                v-model="currentPageP"
                :page-count="totalPagesP"
                :click-handler="page => pageClickHandler(page)"
                :prev-text="'Prev'"
                :next-text="'Next'"
                :container-class="'pagination'"
                :page-class="'page-item'"    
                :no-li-surround="true"   
                v-if="ads.length>0"        
            >
            </paginate>

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
</template>

<script>
import Paginate from 'vuejs-paginate-next';
import axios from 'axios'
import loader from '../share/pageLoader.vue' 
// import infiniteScroll from 'vue-infinite-scroll'


export default {
    data(){
        return{
            flag: require("../../assets/flag.png"),
            current: false,
            old: false,
            nearest: false,
            isActive : false,
            
            // old and current value 
            createdAt : 'asc',

            currentPageP: 1,
            perPageP: 10,
            totalPagesP: 0,

            ads: [],

            loader : true,


            regions : [],
            cities : [],

            city_id : null,
            region_id : null,


            query: null,
            regionQuery : null ,
            loading : false,
            showList : false,
            showList1 : false,

            // city pagination 
            currentPage : null,
            perPage : null,
            total : null,
            showReadMore: true,
            // region pagination
            currentPage1 : null,
            perPage1 : null,
            total1 : null,
            showReadMore1: true,

        }
    },   
    // directives: {
    //     infiniteScroll
    // },

    watch:{
        current(){
            this.getAds()
        },
        old(){
            this.getAds()
        },
        nearest(){
            this.getAds()
        },

        region_id(){
            this.getAds()
        },
        city_id(){
            this.getAds()
        },

    }, 
    components: {
      loader,
      Paginate
    },
    created() {
        this.totalPagesP = Math.ceil(this.ads.length / this.perPageP)
    },
    computed : {
        // displayedData() {
        //     let start = (this.currentPageP - 1) * this.perPageP
        //     let end = start + this.perPageP
        //     return this.ads.slice(start, end)
        // },

        filteredCities() {
            return this.cities.filter(city => {
                return city.name.toLowerCase().includes(this.query.toLowerCase())
            })
        },
        filteredRegions() {
            return this.regions.filter(region => {
                return region.name.toLowerCase().includes(this.regionQuery.toLowerCase())
            })
        },


        pageCount() {
            return Math.ceil(this.total / this.maxPerPage);
        },
        pageOffest() {
            return this.maxPerPage * this.currentPage;
        },
        paginatedOrders() {
            return this.cities.slice(0, this.currentPage * this.maxPerPage);
        },
        pageCount1() {
            return Math.ceil(this.total1 / this.maxPerPage);
        },
        pageOffest1() {
            return this.maxPerPage * this.currentPage1;
        },
        paginatedOrders1() {
            return this.regions.slice(0, this.currentPage1 * this.maxPerPage);
        },


    },

    mounted(){
        this.getAds()
    },
    methods:{
        // get ads 
        async getAds(){
            // Update API parameters based on checkbox values
            // const params = {}
            if (this.current) {
                this.createdAt = 'desc'
            }
            if (this.old) {
                this.createdAt = 'asc'
            }
            if(this.nearest){
                this.nearest = true
            }

            // if( this.region_id ){
            //     this.region_id = this.region_id
            // }

            // if( this.city_id ){
            //     this.city_id = this.city_id
            // }


            await axios.get(`all-ads?page=${this.currentPageP}&region_id=2&created_at=${this.createdAt}&&nearest=${this.nearest}&region_id=${this.region_id}&city_id=${this.city_id}`)
            .then((res)=>{
                this.ads = res.data.data.ads
                    this.totalPagesP = res.data.data.pagination.total_pages
                    this.perPageP = res.data.data.pagination.per_page
                    this.currentPageP = res.data.data.pagination.current_page

                this.loader = false
            })
        },
 

        setNewValue(value, id){
            this.query = value;
            this.city_id = id
            if( this.query == value ){
                this.showList = false
            }
            this.getAds()

            console.log(this.query)

        },
        setNewValueForRegion(value1, id){
            this.regionQuery = value1;
            this.region_id = id
            if( this.regionQuery == value1 ){
                this.showList1 = false
            }
            console.log(this.regionQuery)

            this.getAds()

        },
       

        async getRegions(){
            this.showList1 = true
            await axios.get(`regions?search=${this.regionQuery}&page=${this.currentPage1}`)
            .then( (res)=>{
                this.regions = res.data.data.regions

                this.currentPage1 = res.data.data.pagination.current_page
                this.perPage1 = res.data.data.pagination.per_page
                this.total1 = res.data.data.pagination.total

                if( this.regionQuery == '' ){
                    this.showList1 = true
                }
            } )
            .catch( (err)=>{
                console.error(err)
            } )
        },

        async getData() {
            this.showList = true
            await axios.get(`cities?search=${this.query}&page=${this.currentPage}`)
            .then( (res)=>{
                this.cities = res.data.data.cities

                
                this.currentPage = res.data.data.pagination.current_page
                this.perPage = res.data.data.pagination.per_page
                this.total = res.data.data.pagination.total


                if( this.query == '' ){
                    this.showList = true
                }
            } )
            .catch( (err)=>{
                console.error(err)
            } )
        },
        loadMore() {
            this.currentPage += 1;
            this.getData()
        },
        loadMore1() {
            this.currentPage1 += 1;
            this.getRegions()
        },





        pageClickHandler(page) {
            this.currentPageP = page
            this.getAds()
        },





    },



}
</script>

<style>
    .fa-angle-down1{
        position: absolute;
        left: 10%;
        top: 10%;
    }
    .filter_process{
        width: 80%;
    }
    .pagination{
        display: flex;
        justify-content: center;
        margin-top: 25px;
        direction: ltr;
    }
    .page-item.active .page-link , .active>.page-link, .page-link.active{
        background-color: #78dacb !important;
        border-color: #78dacb !important;
        color: #fff !important;
    }
    .page-link{
        color:#78dacb !important ;
        cursor: pointer;
    }
    .page-item.active .page-link{
        color: #fff !important;
    }
    .page-item.disabled{
        opacity: .6;
    }
    .page-link:focus{
        box-shadow: none !important;
        outline: none !important;
    }
    .searchBox{
        border: none !important;
        box-shadow: 0px 0px 10px #33333329;
        padding: 10px 30px !important;
    }
    .searchBox::placeholder{
        color:#333;
        font-size: 14px;
    }
    .customCheck .fa-angle-down {
        color: #1ec2a8;
        position: absolute;
        left: 14px;
        top: 15px !important;
    }
</style>