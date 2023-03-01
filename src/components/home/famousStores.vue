<template>
    <div class="container mt-4">

        <div class="d-flex justify-content-between">
            <h5 class="labeledSection fw-bold"> {{ $t('home.famousStore') }} </h5>

            <router-link to="/stores" >
                <h6 class="allStores"> {{ $t('home.allStores') }} </h6>
            </router-link>
        </div>

        <section class="stores mt-4">
            <div class="row">
                <div class="col-lg-3 col-md-6 mb-4" v-for="store in stores" :key="store.id">

                    <!-- single store  -->
                    <div class="single_store">
                        <!-- store image -->
                        <div class="store_image">
                            <img :src="store.icon" alt="">
                        </div>
                         
                         <h5 class="fw-bold"> {{ store.name }} </h5>

                         <p class="storeLocation d-flex justify-content-start align-items-center"> 
                            <img :src="locaImage" alt="">
                            <span> {{ store.address }} </span>
                        </p>

                        <router-link :to="'/store/'+store.id" class="button d-flex mx-auto w-75"> {{ $t('home.showStore') }} </router-link>

                        <div class="store_status" v-if="store.is_open==true">
                            <span class="status"></span>
                            <p> {{$t('common.open')}} </p>
                        </div>

                        <div class="store_status " v-else>
                            <span class="status close" style="background:red"></span>
                            <p> {{$t('common.close')}} </p>
                        </div>
                    </div>

                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    data(){
        return{
            // src :  require('../../assets/storeLogo.png'),
            locaImage : require('../../assets/loca.png'),
            // array to get all famous stores => will call the api 
            famousStores : [
                {
                    id : 1, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 2, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 3, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 4, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 5, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 6, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 6, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 6, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 6, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 6, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },
                {
                    id : 6, 
                    src :  require('../../assets/storeLogo.png'),
                    storeName : 'اسم المتجر',
                    storeAddress : 'شارع الصندوق الاسود , الرياض',
                    status : 'مفتوح'
                },

            ],
            
        }
    },
    created(){
        this.famousStores = this.famousStores.slice(0,8)
    },
    props:{
        stores : Array
    }
}
</script>

<style lang="scss">
    .allStores{
        color: #197776;
    }
    .single_store{
        position: relative;
        box-shadow: 0px 0px 13px rgb(51 51 51 / 18%);
        border-radius: 6px;
        padding: 25px 9px 12px 9px;
        transition: .4s all;
        &:hover{
            transform: translate(-4px, -4px);
        }
        .store_image{
            display: flex;
            justify-content: center;
            align-items: center;
            img{
                width: 95px;
                height: 95px;
                border-radius: 6px;
                object-fit: cover;
                margin-bottom: 12px;
            }
        }
        .storeLocation{
            color: #b9b9b9;
            img{
                width: 12px;
                height:16px;
                margin: 0 4px;
            }
        }
        .store_status{
            position: absolute;
            top: 10px;
            left: 10px;
            color: #b9b9b9;
            font-size: 12px;
            display: flex;
            align-items: baseline;
            justify-content: center;
            .status{
                width: 7px;
                height: 7px;
  
                border-radius: 50%;
                background-color: green;
                margin: 0 4px;
            }
        }
        .button{
            border-radius: 5px;
            padding-top: 5px;
            padding-bottom: 5px;
        }
    }
</style>