<template>
          <div class="accordion-item mb-3">
            <h2 class="accordion-header" >
                <button class="accordion-button collapsed" type="button"  data-bs-toggle="modal" data-bs-target="#deleteAccount">
                <div class="d-flex align-items-center">
                    <!-- accordion header icon -->
                    <span class="accHeaderIcon trash"> <i class="fa-solid fa-trash-can" style="color:red"></i> </span>
                    <h5 class="fw-bold"> {{ $t('profile.deleteAccount') }} </h5>
                </div>
                </button>
            </h2>
        </div>

        <!-- delete account modal  -->
        <div class="modal fade" id="deleteAccount" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" style="max-width:60%">
                <div class="modal-content">

                <div class="modal-body">

                    <div class="d-flex flex-column justify-content-center align-items-center">
                        <div class="changeLogo mb-3">
                            <img :src="logo" alt="">
                        </div>

                        <h4 class="fw-bold mb-3">  {{ $t('profile.deleteAccTitle') }} </h4>

                        <p class="fw-bold mb-3"> {{ $t('profile.deleteAccEnsure') }} </p>
                    </div>

                    <form @submit.prevent="deleteAccount()" style="width:65%; margin:auto" ref="deleteAccountForm">
                        

                        <div class="d-flex justify-content-center mt-2 mb-4">
                            <button class="main_btn deleteBtn" :disabled="disabled"> {{$t('profile.deleteAcc')}} </button>
                            <button class="main_btn up" type="button" data-bs-dismiss="modal"> {{$t('profile.revenge')}} </button>
                        </div>
                    </form>
                </div>

                </div>
            </div>
        </div>
</template>

<script>
import axios from 'axios'
export default {
    data(){
        return{
            logo : require('../../assets/logoz.png'),
            disabled : false
        }
    },
    methods:{
        async deleteAccount(){
            this.disabled = true
            const fd = new FormData(this.$refs.deleteAccountForm);


            await axios.post('profile/delete', fd , {
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

                    localStorage.removeItem('token')
                    localStorage.removeItem('keyForMacAndID')
                    localStorage.removeItem('user')
                    localStorage.removeItem('macAddress')
                    localStorage.setItem('IsLoggedIn', 'false')

                    location.reload()
                    this.$router.push('/HomeLogin')

                }else{
                    this.$swal({
                        icon: 'error',
                        title:res.data.msg ,
                        timer : 2000
                    });
                }

                this.disabled = false
            } )
            .catch( (err)=>{
                console.log(err)
            } )
        }
    }
}
</script>

<style>

</style>