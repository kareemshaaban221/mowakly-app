<template>
    <section class="accordion mt-4" id="accordionExample">
        

        <!-- الملف الشخصي  -->
        <personalProfile />

        <!-- single accordion => سياسة الخصوصية -->
        <div class="accordion-item mb-3">
        <h2 class="accordion-header" id="headingSe">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSEf" aria-expanded="false" aria-controls="collapseSEf">
            <div class="d-flex align-items-center">
                <!-- accordion header icon -->
                <img :src="privacy" alt="" class="accHeaderIcon">
                <h5 class="fw-bold"> {{ $t('profile.privacy') }} </h5>
            </div>
            </button>
        </h2>
        <div id="collapseSEf" class="accordion-collapse collapse" aria-labelledby="headingSe" data-bs-parent="#accordionExample">
            <div class="accordion-body">

            <div class="aboutImage">

                <p class="fw-6 aboutP w-75 mx-auto">
                    {{policy}}
                </p>
            </div>

            </div>
        </div>
        </div>

        <!-- single accordion => الشروط والاحكام -->
        <div class="accordion-item mb-3">
        <h2 class="accordion-header" id="headingERw">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collpsesea" aria-expanded="false" aria-controls="collpsesea">
            <div class="d-flex align-items-center">
                <!-- accordion header icon -->
                <img :src="conditions" alt="" class="accHeaderIcon">
                <h5 class="fw-bold"> {{ $t('profile.conditions') }} </h5>
            </div>
            </button>
        </h2>
        <div id="collpsesea" class="accordion-collapse collapse" aria-labelledby="headingERw" data-bs-parent="#accordionExample">
            <div class="accordion-body">


            <div class="aboutImage">

                <p class="fw-6 aboutP mx-auto w-75">
                    {{terms}}
                </p>
            </div>

            </div>
        </div>
        </div>

        <!-- single accordion => كيفية عمل الموقع -->
        <div class="accordion-item mb-3">
        <h2 class="accordion-header" id="headingERw3">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collpsesea1" aria-expanded="false" aria-controls="collpsesea1">
            <div class="d-flex align-items-center">
                <!-- accordion header icon -->
                <img :src="howWork" alt="" class="accHeaderIcon">
                <h5 class="fw-bold"> {{ $t('profile.howWork') }}</h5>
            </div>
            </button>
        </h2>
        <div id="collpsesea1" class="accordion-collapse collapse" aria-labelledby="headingERw3" data-bs-parent="#accordionExample">
            <div class="accordion-body">


            <div class="aboutImage">

                <p class="fw-6 aboutP mx-auto w-75">
                    {{ aboutapp }}
                </p>
            </div>

            </div>
        </div>
        </div>

        <!-- single accordion => اعدادات الاشعارات -->
        <div class="accordion-item mb-3">
        <h2 class="accordion-header" id="headingERw5">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collpsesea5" aria-expanded="false" aria-controls="collpsesea5">
            <div class="d-flex align-items-center">
                <!-- accordion header icon -->
                <img :src="profileAlert" alt="" class="accHeaderIcon">
                <h5 class="fw-bold"> {{ $t('profile.alertSet') }}</h5>
            </div>
            </button>
        </h2>
        <div id="collpsesea5" class="accordion-collapse collapse" aria-labelledby="headingERw5" data-bs-parent="#accordionExample">
            <div class="accordion-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h3> {{ $t('profile.ads') }} </h3>
                        <p class="text-muted"> {{ $t('profile.alertSetting') }} </p>
                    </div>

                    <div>
                        <v-switch
                            v-model="switch1"
                            color="success"
                            @change="changeofferStatus()"
                        ></v-switch>
                    </div>
                </div>
            </div>
        </div>
        </div>

        <!-- single accordion => كيفية عمل الموقع -->
        <div class="accordion-item mb-3">
        <h2 class="accordion-header" id="headingERw6">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collpsesea6" aria-expanded="false" aria-controls="collpsesea6">
            <div class="d-flex align-items-center">
                <!-- accordion header icon -->
                <img :src="howWork" alt="" class="accHeaderIcon">
                <h5 class="fw-bold">{{ $t('profile.commionQues') }}</h5>
            </div>
            </button>
        </h2>
        <div id="collpsesea6" class="accordion-collapse collapse" aria-labelledby="headingERw6" data-bs-parent="#accordionExample">
            <div class="accordion-body">


                <div class="accordion1" id="faq">
                    <div class="accordion-item mb-3" v-for="(faq,i) in FAQS" :key="faq.id">
                        <h2 class="accordion-header" :id="`heading${faq.id}`">
                        <button class="accordion-button" :class="{ collapsed: i > 0 }" type="button" data-bs-toggle="collapse"
                            :data-bs-target="`#collapse${faq.id}`"
                            :aria-expanded="i === 0"
                            :aria-controls="`collapse${faq.id}`"
                        >
                            {{ faq.question }}
                        </button>
                        </h2>
                        <div :id="`collapse${faq.id}`" class="accordion-collapse collapse"  :class="{ show: i === 0 }"  :aria-labelledby="`heading${faq.id}`" data-bs-parent="#faq">
                        <div class="accordion-body">
                            {{ faq.answer }}
                        </div>
                        </div>
                    </div>
                    

                </div>


            </div>
        </div>
        </div>

        <!-- single accordion => لفغة الموقع -->
        <div class="accordion-item mb-3">
        <h2 class="accordion-header" id="headingERw77">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collpsesea55" aria-expanded="false" aria-controls="collpsesea55">
            <div class="d-flex align-items-center">
                <!-- accordion header icon -->
                <img :src="profilell" alt="" class="accHeaderIcon">
                <h5 class="fw-bold"> {{ $t('profile.siteLang') }} </h5>
            </div>
            </button>
        </h2>
        <div id="collpsesea55" class="accordion-collapse collapse" aria-labelledby="headingERw77" data-bs-parent="#accordionExample">
            <div class="accordion-body">
                <div class="d-flex justify-content-between flex-column">
                    <h2 class="text-center fw-bold"> {{ $t('profile.welcome') }}  </h2>
                    <p class="text-center text-muted"> {{ $t('profile.chooseLang') }} </p>

                    <div class="lang_buttons d-flex justify-content-center mt-4">

                        <button class="btn d-flex flex-column justify-content-center align-items-center" @click="setArabic()">
                            <!-- lang image  -->
                            <div class="lang_image">
                                <img :src="suadia" alt="">
                            </div>
                            <h5 class="fw-bold">{{ $t('profile.arabic') }}</h5>

                        </button>

                        <button class="btn d-flex flex-column justify-content-center align-items-center" @click="setEnglish()">
                            <!-- lang image  -->
                            <div class="lang_image">
                                <img :src="usa" alt="">
                            </div>                               
                             <h5 class="fw-bold">{{ $t('profile.english') }}</h5>

                        </button>
                    </div>
                </div>
            </div>
        </div>
        </div>

        <!-- single accordion => حذف الحساب -->
        <deleteAccount />



    </section>
</template>

<script>

import axios from 'axios'
import personalProfile from './personalProfile.vue'
import deleteAccount from './deleteAccount.vue'

export default {
    data(){
        return{
            src : require('../../assets/profile.png'),
            privacy : require('../../assets/wallet.png'),
            conditions : require('../../assets/terms.png'),
            howWork : require('../../assets/profileoo.png'),
            profileAlert : require('../../assets/profileAlert.png'),
            profilell : require('../../assets/profilell.png'),
            suadia : require('../../assets/saudi.png'),
            usa : require('../../assets/united_states.png'),
            logo : require('../../assets/logoz.png'),
            items: [],
            switch1: false,
            ar : 'ar',
            en : 'en',
            lang : '',

            // user data
            name  : '',
            phone : null,
            old_password : '',
            new_password : '',
            confirmPassword : '',
            country_key : '',
            disabled : false,
            isPhoneChanged : false


            // FAQS : [
            //     {
            //         id:1,
            //         faqTitle : 'كيفية عمل المقع',
            //         faqDesc : '111111111111111111111111111111111111111111111111111111111111111',
            //         unique : 1
            //     },
            //     {
            //         id:2,
            //         faqTitle : 'كيفية عمل المقع',
            //         faqDesc : '111111111111111111111111111111111111111111111111111111111111111',
            //         unique : 2
            //     },
            //     {
            //         id:3,
            //         faqTitle : 'كيفية عمل المقع',
            //         faqDesc : '111111111111111111111111111111111111111111111111111111111111111',
            //         unique : 3
            //     },
            // ]
        }
    },
    props : {
        FAQS : Array,
        policy : String,
        aboutapp : String,
        whous : String,
        terms : String,
    },
    components:{
        personalProfile,
        deleteAccount
    },
    mounted(){
        // this.getCountriesCode();
        // this.getUser()
    },
    
    methods:{

        // change language and local 
        setArabic(){
            localStorage.setItem("locale", this.ar);
            this.$i18n.locale = this.ar
            location.reload();
        },
        setEnglish(){
            localStorage.setItem('locale', this.en);
            this.$i18n.locale = this.en
            location.reload()
        },
        
        // ads option switch 
        async changeofferStatus(){
            await axios.post('control-notification',{
                offers_notify : this.switch1   
            })
            .then( (response)=>{
                if( response.data.code == 200 && response.data.key == "success" ){
                    this.$swal({
                        icon: 'success',
                        title: response.data.msg,
                        timer : 1000
                    });
                }else{
                    this.$swal({
                        icon: 'error',
                        title: response.data.msg,
                        timer : 1000
                    });
                }
            } )
            .catch( (err)=>{
                console.error(err)
            } )
        },

    },

    
}
</script>



<style lang="scss">
.accHeaderIcon.trash{
    background: rgba(255, 0, 0, 0.13);
    display: flex;
    justify-content: center;
    align-items: center;
}
.deleteBtn{
    background-color:red ;
    margin: 0 20px;
}
.lang_buttons{
    button{
        height: 200px;
        width: 200px;
        border: 1px solid #e5dbdb;
        &:first-of-type{
            margin-left: 20px;
        }
        .lang_image{
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background-color: rgb(245 244 244);
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            img{
                width: 53px;
                height: 38px;
                object-fit: cover;
            }
        }
    }
}
.changeLogo img{
    width: 163px;
    height: 113px;
    object-fit: cover;
}
.accordion .fa-user{
    margin: auto;
    color: #24c3aa;
}
.accordion{
    width: 70%;
    margin: auto;
}
.accordion-button {
    border-radius: 10px;
}

.accordion-button::after {
    margin-right: auto;
    margin-left: 0 !important;
    transform: rotate(90deg);
}

.accordion-button:not(.collapsed)::after {
    transform: rotate(0deg) !important;
}

.accordion-item {
    border: none !important;
    border-radius: 12px;
    background-color: #f7f7f7;
}

.accHeaderIcon {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    margin-left: 12px;
}

.accordion-item:last-of-type {
    border-bottom-right-radius: 12px;
    border-bottom-left-radius: 12px;
}

.accordion-item:last-of-type .accordion-button.collapsed {
    border-bottom-right-radius: 12px;
    border-bottom-left-radius: 12px;
}

.accordion-item:first-of-type .accordion-button {
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}

.accordion-item:first-of-type {
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}
.accordion-button{
    height: 55px !important;
    border: none !important;
    box-shadow: 5px 0px 16px #87767629 !important;
    outline: none !important;
}

@media( max-width:678px ){
    .accordion{
        width: 95%;
    }
}
</style>