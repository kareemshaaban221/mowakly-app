<template>

  <!-- loader  -->
  <loader v-if="loader" />
  <section id="stores" class="mt-5 mb-5" v-if="stores.length>0">
    <div class="container">
      <h5 class="labeledSection fw-bold"> {{ $t('nav.stores') }} </h5>

      <!-- filter process  -->
      <section class="filter_process mt-3">
        <h6 class=""> {{ $t('nav.storeDepend') }} </h6>

        <form>
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
                    <!-- <i class="fa-solid fa-angle-down"></i> -->
                </v-col>

                <v-col class="customCheck d-flex" cols="12" sm="3">
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

                    <!-- <i class="fa-solid fa-angle-down"></i> -->
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


      </section>

  
      <!-- filtered store  -->
      <section class="filtered_section mt-3">

        <v-lazy
          v-model="isActive"
          :options="{
            threshold: .5
          }"
          min-height="200"
          transition="scroll-y-transition"
        >

        <div class="row">          

            <div class="col-md-4 mb-4" v-for="store in stores" :key="store.id">

              <v-lazy
                v-model="isActive"
                :options="{
                  threshold: .5
                }"
                min-height="200"
                transition="scroll-y-transition"

              >

              <!-- single store  -->
              <div class="single_store">
                <!-- store image -->
                <div class="store_image">
                  <img :src="store.icon" alt="" />
                </div>

                <h5 class="text-center">{{ store.name }}</h5>

                <p
                  class="
                    storeLocation
                    d-flex
                    justify-content-start
                    align-items-center
                  "
                >
                  <img :src="locaImage" alt="" />
                  <span> {{ store.address }} </span>
                </p>

                <router-link
                  :to="'/store/'+store.id"
                  class="button d-flex justify-content-center mx-auto w-75"
                >
                  {{ $t('home.showStore') }}
                </router-link>

                <div class="store_status" v-if="store.is_open==true">
                  <span class="status"></span>
                  <p> {{ $t('common.open') }} </p>
                </div>

                <div class="store_status" v-else>
                  <span class="status close" style="background:red"></span>
                  <p>{{ $t('common.close') }}</p>
                </div>
              </div>
              </v-lazy>
            </div>

        </div>

        </v-lazy>
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
                v-if="stores.length>0"        
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


export default {
  data() {
    return {
      src: require("../../assets/storeLogo.png"),
      flag: require("../../assets/flag.png"),

      current: false,
      old: false,
      nearest: false,
      isActive: false,

      createdAt : 'asc',
      loader : true ,

   
      selectedOption1:'',
      selectedOption2: '',

      currentPageP: 1,
      perPageP: 10,
      totalPagesP: 0,


      stores : [],




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

      

    };
  },


  watch:{
        current(){
            this.getStores()
        },
        old(){
            this.getStores()
        },
        nearest(){
            this.getStores()
        }

  },
  
  
  components:{
    Paginate,
    loader
  },
  created() {
        this.totalPagesP = Math.ceil(this.stores.length / this.perPageP)
  },


  computed: {
      // displayedData() {
      //       let start = (this.currentPageP - 1) * this.perPageP
      //       let end = start + this.perPageP
      //       return this.stores.slice(start, end)
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
  }
  ,
    methods:{
        


        async getStores(){

          if (this.current) {
                this.createdAt = 'desc'
            }
            if (this.old) {
                this.createdAt = 'asc'
            }
            if(this.nearest){
                this.nearest = true
            }


          await axios.get(`nearstores?lat=${localStorage.getItem('lat')}&long=${localStorage.getItem('lng')}&page=${this.currentPageP}&category=${this.$route.query.slug}&created_at=${this.createdAt}&nearest=${this.nearest}&region_id=${this.region_id}&city_id=${this.city_id}`)
          .then( (res)=>{
            this.stores = res.data.data.stores
            this.totalPagesP = res.data.data.pagination.total_pages
            this.perPageP = res.data.data.pagination.per_page
            this.currentPageP = res.data.data.pagination.current_page

            this.loader = false
          } )
        },


        setNewValue(value, id){
            this.query = value;
            this.city_id = id
            if( this.query == value ){
                this.showList = false
            }
            this.getStores()

            console.log(this.query)

        },
        setNewValueForRegion(value1, id){
            this.regionQuery = value1;
            this.region_id = id
            if( this.regionQuery == value1 ){
                this.showList1 = false
            }
            console.log(this.regionQuery)

            this.getStores()

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
            this.getStores()
        },

    },
    mounted(){
      this.getStores();
    }
};
</script>

<style lang="scss">
$base-color: #1ec2a8;
.noFound{
  width:40%;
  margin:auto;
  margin-top:60px;
}
.filter_process{
    h6{
        font-size: 20px;
    }
}
.v-select .v-field .v-field__append-inner > .v-icon {
  color: #1ec2a8;
}
.v-field--variant-filled .v-field__overlay {
  background-color: #fff;
  box-shadow: 0px 0px 15px rgba(51, 51, 51, 0.137);
}
.v-field--variant-filled .v-field__outline::before,
.v-field--variant-underlined .v-field__outline::before {
  border: none;
}
.customCheck {
  position: relative;
  .v-input__control {
    box-shadow: 1px 3px 10px #3333332b;
    border-radius: 5px;
    height: 47px;
  }
  .v-label.v-field-label {
    color: #333;
    opacity: 1;
    margin: 0 28px;
    margin-top: -4px;
  }
  img {
    width: 9px;
    height: 16px;
    position: absolute;
    right: 22px;
    top: 30px;
  }
}
.checks {
  .v-selection-control--inline .v-label {
    color: #333;
    opacity: 1;
    font-weight: 600;
    font-size: 15px;
  }
}
</style>
<style>
  .customCheck .form-select{
    background-image:none !important ;
    border: none;
    background-color: #fff;
    box-shadow: 0px 0px 15px rgba(51, 51, 51, 0.137);
    height : 45px;
  }
    .customCheck  .fa-angle-down{
      color: #1ec2a8;
      position: absolute;
      left: 23px;
      top: 28px;
    }
</style>