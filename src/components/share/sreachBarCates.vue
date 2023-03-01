<template>
    <section class="searchBar" v-if="showStoreAd">
        
        <div class="position-relative">
            <input type="text" v-model="query" name="query" :placeholder="$t('nav.searchForCats')" class="form-control searchBox" @input="getData()">
            <i class="fa-solid fa-magnifying-glass"></i>
        </div>

        <div v-if="showList">
            <ul class="list-group" style="z-index:9999" v-if="categories.length>0">
                <li class="list-group-item" v-for="(item,index) in categories" :key="item.id" >
                    <router-link :to="{ name: 'fileredcates', params: { id: item.id }, query: { slug: item.slug } }" @click="setNewValue(item.name ,item.id, item.slug )">
                        {{index+1}}.{{item.name}}
                    </router-link>
                </li>
            </ul>
            <ul class="list-group" v-else>
                <li class="list-group-item">No Data Found</li>
            </ul>
        </div>


    </section>


    <!-- stores search  -->
    <section class="searchBar" v-if="this.$route.path == '/stores'"> 
        <div class="position-relative">
            <input type="text" v-model="storeQuery" name="storeQuery" :placeholder="$t('nav.searchForStore')" class="form-control searchBox" @input="getStores()">
            <i class="fa-solid fa-magnifying-glass"></i>
        </div>

        <div v-if="showListStore">
            <ul class="list-group" style="z-index:9999" v-if="nearstores.length>0">
                <li class="list-group-item" v-for="(item,index) in nearstores" :key="item.id" >
                    <router-link :to="{ name: 'stores' }" @click="setNewValueForStore(item.name )">
                        {{index+1}}.{{item.name}}
                    </router-link>
                </li>
            </ul>
            <ul class="list-group" v-else>
                <li class="list-group-item">No Data Found</li>
            </ul>
        </div>
    </section>
</template>

<script>

import axios from 'axios'
export default {
    data(){
        return{
            categories : [],
            query: null,
            loading : false,
            showList : false,
            catId : null,
            catSlug : '',
            showStoreAd : true,


            // stores params 
            nearstores : [],
            storeQuery : null,
            showListStore : false,


            updatedStoreName : ''
        }
    },
    
    methods:{

        // get categories 
        async getData() {
            await axios.get(`categories?search=${this.query}`)
            .then( (res)=>{
                this.categories = res.data.data.categories

                this.showList = true
                if( this.query == '' ){
                    this.showList = false
                }
            } )
            .catch( (err)=>{
                console.err(err)
            } )
        },

        // get categories 
        setNewValue(value, id , slug){

            if( this.$route.path.includes('fileredcategories') ){
                // console.log( this.$route.fullPath )
                    this.$route.fullPath = `/fileredcategories/${id}?slug=${slug}`

                setTimeout(() => {
                    location.reload()
                }, 10);
            }
            this.query = value;

        },




        // get stores 
        async getStores(){
            await axios.get(`nearstores?lat=${localStorage.getItem('lat')}&long=${localStorage.getItem('lng')}&search=${this.storeQuery}`)
            .then( (res)=>{
                this.nearstores = res.data.data.stores

                this.showListStore = true
                if( this.storeQuery == '' ){
                    this.showListStore = false
                }

            } )
            .catch( (err)=>{
                console.err(err)
            } )
        },
        // get stores 
        setNewValueForStore(value){

            // if( this.$route.path.includes('stores') ){
            //     // console.log( this.$route.fullPath )
                    

            //     setTimeout(() => {
            //         location.reload()
            //     }, 10);
            // }
            this.updatedStoreName = value
            // localStorage.setItem('searchStore', value)
            this.storeQuery = value;

            this.showListStore = false

        },
    },

    mounted(){

        // hide main search bar that search for categories from stores and ads page 
        if( this.$route.path == "/stores" || this.$route.path == "/offers" ){
            this.showStoreAd = false
        }        
    },
    updated(){
        sessionStorage.setItem('searchStore',this.updatedStoreName)        
    }

}
</script>

<style scoped>
    .list-group{
        z-index: 9999;
        position: relative;
        max-height: 190px;
        overflow-y: auto;
    }
    .form-control{
        height: 46px;
        box-shadow: 0px 0px 10px #33333321;
    }
    .form-control::placeholder{
        color:#0c4e50;
        font-weight: normal;
    }
</style>