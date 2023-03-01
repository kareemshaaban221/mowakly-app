<template>
    <!-- loader  -->
    <loader v-if="loader" />

  <div class="container">
    <section v-if="notes.length>0">
        <ul class="notifyList" >
        <li v-for="not in notes" :key="not.id">
            <div  class="alert_Icon">
                <div class="d-flex align-items-center gap15">
                <v-img lazy-src="@/assets/bell.png" height="25" width="25" :src="not.icon"></v-img>
                <div class="d-flex flex-column">
                    <span class="fontBold font13"> {{ not.title }} </span>
                    <span class="font10"> {{ not.message }} </span>
                </div>
                </div>
            </div>
        </li>
    </ul>
    <paginate
                v-model="currentPageP"
                :page-count="totalPagesP"
                :click-handler="page => pageClickHandler(page)"
                :prev-text="'Prev'"
                :next-text="'Next'"
                :container-class="'pagination'"
                :page-class="'page-item'"    
                :no-li-surround="true"   
                v-if="notes.length>0"        
            >
    </paginate>
    </section>

    
   <section v-else>
    <v-alert
      type="info"
      class="noFound"
    >
      {{ $t('common.notFound') }}
    </v-alert>
   </section>
    
  </div>
</template>

<script>
// import { inject } from 'vue'
  import Paginate from 'vuejs-paginate-next';
import axios from 'axios'
import loader from '../share/pageLoader.vue'

export default {
    props : {

    },
    data(){
        return{
            currentPageP: 1,
            perPageP: 10,
            totalPagesP: 0,
            notes : [],
            loader : true
        }
    },
    components:{
        Paginate,
                loader

    },
    methods:{
         async getNotification(){
            await axios.get(`notifications?page=${this.currentPageP}`, {
                headers : {
                    Authorization:  `Bearer ${localStorage.getItem('token')}`
                }
            })
            .then( (res)=>{
                this.notes = res.data.data.notifications
                this.totalPagesP = res.data.data.pagination.total_pages
                this.perPageP = res.data.data.pagination.per_page
                this.currentPageP = res.data.data.pagination.current_page

                this.loader = false
            } )
            .catch( (err)=>{
                console.error(err)
            } )
        },
        pageClickHandler(page) {
            this.currentPageP = page
            this.getNotification()
        },
    },
    created() {
        this.totalPagesP = Math.ceil(this.notes.length / this.perPageP)
    },
    mounted(){
        this.getNotification()
    }
};
</script>

<style lang="scss" scoped>
    .notifyList{
        margin: 40px 0;
        padding: 0;
        list-style: none;
        .v-responsive {
            flex: unset;
        }
        li{
            margin: 8px 0;
            transition: .3s all ease;
            background-color: #fff;
                &:hover{
                    box-shadow: inset 0px 100px 0px #1ec2a82e;
            }
            .alert_Icon{
                display: block;
                color: #000;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 0 6px #ddd;
            }
            
        }
    }
</style>
