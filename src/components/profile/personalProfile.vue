<template>
    <!-- single accordion => الملف الشخصي -->
    <div class="accordion-item mb-3">
        <h2 class="accordion-header" id="headingOne">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
            <div class="d-flex align-items-center">
                <!-- accordion header icon -->
                <img :src="src" alt="" class="accHeaderIcon">
                <h5 class="fw-bold"> {{ $t('profile.personal') }} </h5>
            </div>
            </button>
        </h2>
        <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
            <div class="accordion-body">

                <!-- start personal form  -->
                <form id="personalInfoForm" class=" mt-5" ref="profileForm">



                <!-- username  -->
                <div class="mt-3 mb-3">
                    <h6 class="fontBold mb-0"> {{ $t('profile.username') }} </h6>
                    <div class="form__label">
                    <input
                        class="default_input"
                        type="text"
                        required
                        :placeholder="$t('profile.enterUser')"
                        name="name"
                        v-model="name"
                        
                    />
                    <label class="float__label" for="">  {{ $t('profile.enterUser') }}  </label>
                    <span class="icon-input">
                        <i class="fa-solid fa-user"></i>
                    </span>
                    </div>
                </div>

                <!-- phone  -->
                <div class="mt-3 mb-3">
                    <h6 class="fontBold mb-0"> {{ $t('profile.phone') }} </h6>
                    <div class="form__label position-relative">
                        <input
                            class="default_input"
                            type="number"
                            required
                            :placeholder="$t('profile.enterPhone')"
                            name="phone"
                            v-model="phone"
                            ref="inputChange"
                            @input="changed()"
                        />
                        <label class="float__label" for="">{{ $t('profile.enterPhone') }}</label>
                        <span class="icon-input">
                            <v-img
                            lazy-src="../../assets/noun_mobile.png"
                            height="25"
                            width="25"
                            src="../../assets/noun_mobile.png"
                            ></v-img>
                        </span>
                        <v-select :items="items" class="countryKay" v-model="country_key" name="country_key" solo></v-select>
                    </div> 
                </div>



                <!-- save  -->
                <div class="d-flex justify-content-between mx-auto mt-3 mb-5">
                    <button class="main_btn up" style="min-width:38% ; color:#fff" data-bs-toggle="modal" data-bs-target="#changePass" type="button" > {{$t('profile.changePassword')}} </button>
                    <button class="main_btn up" style="min-width:38%" @click.prevent="updateProfile()" :disabled="disabled" data-bs-toggle="modal" data-bs-target="#avtiveCodeModal"> {{$t('profile.save')}} </button>


                
                </div>
                </form>
                <!-- end personal form  -->

                <!-- active code modal modal  -->
                <div v-if="isPhoneChanged"  class="modal fade" id="avtiveCodeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" ref="activeCodeModal">
                    <div class="modal-dialog modal-dialog-centered" style="max-width:75%">
                        <div class="modal-content">

                        <div class="modal-body">

                            <div class="d-flex flex-column justify-content-center align-items-center">
                                <div class="changeLogo mb-3">
                                    <img :src="logo" alt="">
                                </div>

                                <h4 class="fw-bold mb-3">  {{ $t('profile.welcome') }} </h4>

                                <p class="fw-bold mb-3"> {{ $t('profile.sendActiveCode') }} </p>
                            </div>

                            <form @submit.prevent="ActiveCode()" style="width:65%; margin:auto" ref="changePassForm">
                                <v-otp-input
                                    ref="otpInput"
                                    id="otpChange"
                                    input-classes="otp-input"
                                    separator=" "
                                    :num-inputs="6"
                                    v-modal="otpInput"
                                    name="otpInput"
                                    :is-input-num="true"
                                    @on-change="handleOnChange"
                                    @on-complete="handleOnComplete"
                                    style="justify-content:center"
                                />

                                <div class="d-flex justify-content-center mt-4">
                                    <button class="main_btn up" :disabled="disabled"> {{$t('profile.save')}} </button>
                                </div>
                            </form>
                        </div>

                        </div>
                    </div>
                </div>

                <!-- change password modal  -->
                <div class="modal fade" id="changePass" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" style="max-width:75%">
                        <div class="modal-content">

                        <div class="modal-body">

                            <div class="d-flex flex-column justify-content-center align-items-center">
                                <div class="changeLogo mb-3">
                                    <img :src="logo" alt="">
                                </div>

                                <h4 class="fw-bold mb-3">  {{ $t('profile.welcome') }} </h4>

                                <p class="fw-bold mb-3"> {{ $t('profile.pleaseChange') }} </p>
                            </div>

                            <form @submit.prevent="changePass()" style="width:65%; margin:auto" ref="changePassForm">
                                <!-- current password  -->
                                <div class="mt-3 mb-3">
                                    <h6 class="fontBold mb-0">{{ $t('profile.currentPass') }}</h6>
                                    <div class="form__label">
                                    <input
                                        class="default_input"
                                        :type="typePass"
                                        required=""
                                        :placeholder="$t('profile.enterPass')"
                                        name="old_password"
                                        v-model="old_password"
                                    />
                                    <label class="float__label" for="">{{ $t('profile.enterPass') }}</label>
                                    <span class="icon-input">
                                        <v-img
                                        lazy-src="../../assets/Unlock.png"
                                        height="25"
                                        width="25"
                                        src="../../assets/Unlock.png"
                                        ></v-img>
                                    </span>
                                    <v-btn class="float_btn" color="white" elevation="0" small
                                        @click="showPassword"
                                        ><v-img
                                        lazy-src="../../assets/eye-close.png"
                                        height="25"
                                        width="25"
                                        src="../../assets/eye-close.png"
                                        ></v-img>
                                    </v-btn>
                                    </div>
                                </div>

                                <!-- new password  -->
                                <div class="mt-3 mb-3">
                                    <h6 class="fontBold mb-0">{{ $t('profile.newPassword') }}</h6>
                                    <div class="form__label">
                                    <input
                                        class="default_input"
                                        :type="typeNewPassword"
                                        required=""
                                        :placeholder="$t('profile.enterPass')"
                                        name="new_password"
                                        v-model="new_password"
                                    />
                                    <label class="float__label" for="">{{ $t('profile.enterPass') }}</label>
                                    <span class="icon-input">
                                        <v-img
                                        lazy-src="../../assets/Unlock.png"
                                        height="25"
                                        width="25"
                                        src="../../assets/Unlock.png"
                                        ></v-img>
                                    </span>
                                    <v-btn class="float_btn" color="white" elevation="0" small
                                        @click="showNewPassword"
                                        ><v-img
                                        lazy-src="../../assets/eye-close.png"
                                        height="25"
                                        width="25"
                                        src="../../assets/eye-close.png"
                                        ></v-img>
                                    </v-btn>
                                    </div>
                                </div>

                                <!-- confirm  password  -->
                                <div class="mt-3 mb-3">
                                    <h6 class="fontBold mb-0">{{ $t('profile.confirmPass') }}</h6>
                                    <div class="form__label">
                                    <input
                                        class="default_input"
                                        :type="typePassConfrm"
                                        required=""
                                        :placeholder="$t('profile.enterConfirm')"
                                        name="confirmPassword"
                                        v-model="confirmPassword"
                                    />
                                    <label class="float__label" for="">{{ $t('profile.enterConfirm') }}</label>
                                    <span class="icon-input">
                                        <v-img
                                        lazy-src="../../assets/Unlock.png"
                                        height="25"
                                        width="25"
                                        src="../../assets/Unlock.png"
                                        ></v-img>
                                    </span>
                                    <v-btn class="float_btn" color="white" elevation="0" small
                                        @click="confrmPassword"
                                        ><v-img
                                        lazy-src="../../assets/eye-close.png"
                                        height="25"
                                        width="25"
                                        src="../../assets/eye-close.png"
                                        ></v-img>
                                    </v-btn>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-center mt-4">
                                    <button class="main_btn up" > {{$t('profile.save')}} </button>
                                </div>
                            </form>
                        </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
// Import in a Vue component
import VOtpInput from "vue3-otp-input";


export default {
    data(){
        return{
            // showME: false,
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
            isPhoneChanged : false,

            typePass: "password",
            typeNewPassword : 'password',
            typePassConfrm: "password",
            dynamicAuto : false

        }
    },

    components: {
        VOtpInput,
    },
    setup() {
        const otpInput = null;

        const handleOnComplete = (value) => {
        console.log("OTP completed: ", value);
        };

        const handleOnChange = (value) => {
        console.log("OTP changed: ", value);
        };

        return { handleOnComplete, handleOnChange, otpInput };
    },
    methods:{

        showPassword() {
            this.typePass = this.typePass === "password" ? "text" : "password";
        },
        showNewPassword() {
            this.typeNewPassword = this.typeNewPassword === "password" ? "text" : "password";
        },
        confrmPassword() {
            this.typePassConfrm = this.typePassConfrm === "password" ? "text" : "password";
        },

        // update profile 
        changed(){ 
             this.isPhoneChanged = true
        },
        async updateProfile(){
            // if(this.$refs.inputChange == 0 + this.phone){
            //     this.isPhoneChanged = false

            // document.querySelectorAll('.modal-backdrop').forEach(element => {
            //         element.classList.add('d-none')
            // });    
            // console.log('sderftgyhjkl')
            // }

            
           this.dynamicAuto = true
            this.disabled = true
            const fd = new FormData(this.$refs.profileForm);

            await axios.post('profile/update', fd , {
                headers : {
                    Authorization:  `Bearer ${localStorage.getItem('token')}`
                }

            })
            .then( (res)=>{
                if( res.data.code == 200 && res.data.key=="success" ){
                    
                    
                    localStorage.setItem('updatedUserName', this.name)
                    localStorage.setItem('isUserNameUpdated', true)
                    
                    this.isPhoneChanged = res.data.data.has_changed_phone

                    if( this.isPhoneChanged == 'true' ){
                        this.isPhoneChanged = true

                        // auto focus first element in otp 
                        const modal = document.getElementById('avtiveCodeModal');
                            modal.addEventListener('shown.bs.modal', function () {
                            const otpInput = document.getElementById('otpChange')
                            otpInput.firstElementChild.firstElementChild.focus();
                        });

                    }else if(this.isPhoneChanged == 'false'){
                        this.$nextTick(() => {
                            // this.$refs.activeCodeModal.classList.add('d-none')
                            this.isPhoneChanged = false
                        });
                        this.$swal({
                            icon: 'success',
                            title:res.data.msg ,
                            timer : 2000,
                            showConfirmButton: false,
                        });

                        location.reload()
                        
                    }

                    
                }else{
                    this.$swal({
                        icon: 'error',
                        title:res.data.msg,
                        timer : 2000,
                        showConfirmButton: false,
                    });
                }
                this.disabled = false
            } )
            .catch( (err)=>{
                console.log(err) 
            } )
            
        },

        async ActiveCode(){


            


            this.disabled = true
            const formData = new FormData()

            //convert otp array to a string then to a number
            let otpString = JSON.stringify(this.$refs.otpInput.otp.join(""));
            let otpsNumber = JSON.parse(otpString)


            formData.append('code', otpsNumber);

            formData.append('phone', localStorage.getItem('phone'))


            


            console.log(otpsNumber);
            await axios.post(
                `profile/changed-phone-activation`,
                formData ,
            ).then((response) => {
                if(response.status == 200 && response.data.key == "success"){
                this.$swal({
                    icon: 'success',
                    title: response.data.msg,
                    timer : 2000,
                    showConfirmButton: false,

                });

                this.$refs.activeCodeModal.classList.remove('show');
                this.$refs.activeCodeModal.style.display = 'none';
                document.querySelector('.modal-backdrop').style.display = "none"


                }else{
                this.$swal({
                    icon: 'error',
                    title: response.data.msg,
                    timer : 2000,
                    showConfirmButton: false,

                });
                }

                this.disabled = false
            }).catch(e => {
                console.error(e);
            })
            .finally( ()=>{
                location.reload()
            } )

        },
        // get user data 
        async getUser(){
            await axios.get('profile/show', {
                headers : {
                    Authorization:  `Bearer ${localStorage.getItem('token')}`
                }
            })
            .then( (res)=>{
                this.name = res.data.data.user.name
                this.phone = res.data.data.user.phone
                this.country_key = res.data.data.user.country_key
   
            } )
            .catch( (err)=>{
                console.error(err)
            } )
        },
        // get countryCode 
        async getCountriesCode(){
        await axios.get('countries')
        .then( (response)=>{
            // this.items = response.data.data.countries;


            for( let i = 0 ; i < response.data.data.countries.length ; i++){
            this.items.push(response.data.data.countries[i].calling_code)

            // console.log(this.items)
            }

        } )
        },


        // change Pass 
        async changePass(){
            this.disabled = true
            const fd = new FormData( this.$refs.changePassForm );

            await axios.post('profile/update-password', fd,{
                headers : {
                    Authorization:  `Bearer ${localStorage.getItem('token')}`
                }
            })
            .then( (res)=>{
                if( res.data.code == 200 && res.data.key=="success" ){
                    this.$swal({
                        icon: 'success',
                        title:res.data.msg ,
                        timer : 2000
                    });
                }else{
                    this.$swal({
                        icon: 'error',
                        title:res.data.msg,
                        timer : 2000
                    });
                }
                this.disabled = false

            } )
            .catch( (err)=>{
                console.error(err)
            } )
        }
    },

    mounted(){
        this.getCountriesCode();
        this.getUser()


        
    },
}
</script>

<style scoped>
    .countryKay{
        position: absolute;
        left: 0;
        top: -3px;
    }
    .otp-input{
        justify-content: center;
    }
</style>