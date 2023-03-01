<template>
  <div>
    <form ref="form" @submit.prevent="submitForm">
      <div class="d-flex align-items-center flex-column">
        <v-img
          lazy-src="../../assets/logoz.png"
          height="200"
          width="200"
          src="../../assets/logoz.png"
        ></v-img>

        <h2 class="fontBold">{{ $t('auth.wellcome') }}</h2>

        <p class="fontBold">
          {{ $t('auth.dataLogin') }}
        </p>
      </div>
      <div class="mt-3 mb-3">
        <h6 class="fontBold mb-0">{{ $t('auth.phone') }}</h6>
        <div class="form__label">
          <input
            class="default_input"
            type="number"
            required=""
            v-model="phone"
            name="phone"
            placeholder="{{ $t('auth.insert') }} {{ $t('auth.phone') }}"
          />
          <label class="float__label" for="">{{ $t('auth.insert') }} {{ $t('auth.phone') }}</label>
          <span class="icon-input">
            <v-img
              lazy-src="../../assets/noun_mobile.png"
              height="25"
              width="25"
              src="../../assets/noun_mobile.png"
            ></v-img>
          </span>
          <v-select  :items="items" v-model="calling_code" name="calling_code" ></v-select>
        </div>
      </div>

      <div class="mt-3 mb-3">
        <h6 class="fontBold mb-0">{{ $t('auth.password') }}</h6>
        <div class="form__label">
          <input
            class="default_input"
            required=""
            v-model="password"
            name="password"
            placeholder="{{ $t('auth.insert') }} {{ $t('auth.password') }}"
            :type="passwordFieldType"
          />
          <label class="float__label" for="">{{ $t('auth.insert') }} {{ $t('auth.password') }}</label>
          <span class="icon-input">
            <v-img
              lazy-src="../../assets/Unlock.png"
              height="25"
              width="25"
              src="../../assets/Unlock.png"
            ></v-img>
          </span>
          <v-btn class="float_btn" color="white" elevation="0" small 
            type="button" @click="switchVisibility"
            ><v-img
              lazy-src="../../assets/eye-close.png"
              height="25"
              width="25"
              src="../../assets/eye-close.png"
            ></v-img>
          </v-btn>
        </div>
      </div>
      <router-link class="default-link" :to="{ name: 'forgetPassowrd' }">
        {{ $t('auth.forgitPassword') }}
        </router-link>
      <div class="mt-3 mb-3 d-flex justify-content-center">
        <button class="main_btn up" color="#1ec2a8" elevation="0" x-large :disabled="disabled">{{ $t('auth.login') }}</button>
      </div>
      <div class="mt-3 mb-3 d-flex justify-content-center" style="gap:5px">
        <span>{{ $t('auth.notsigned') }}</span>
        <router-link class="default-link mainColor" :to="{ name: 'HomeRegester' }"
        >{{ $t('auth.signup') }}</router-link
        >
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data: () => ({
    items: [],
    password: "",
    phone: "",
    calling_code: null,
    passwordFieldType: "password",
    disabled : false,
    website : true,
    token : ''
  }),
  methods: {
    switchVisibility() {
      this.passwordFieldType = this.passwordFieldType === "password" ? "text" : "password";
    },

    async submitForm(){
      this.disabled = true
      const formData = new FormData(this.$refs.form);
      formData.append('website', this.website)
      formData.append('device_id', localStorage.getItem('keyForMacAndID'))
      formData.append('device_type', 'android')
      await axios.post(
        `login`,
        formData ,
      ).then((response) => {
        if(response.status == 200 && response.data.key == "success"){
          this.$swal({
              icon: 'success',
              title: this.$t('common.loginSuccess'),
              timer: 2000,
              showConfirmButton: false,
          });

          let user = JSON.stringify(response.data.data.user)
          this.token = response.data.data.token


          // set the user as logged in 
          localStorage.setItem('IsLoggedIn', true);


          
          localStorage.setItem('token', this.token)
          // this.$store.dispatch('saveToken', response.data.data.token)
          // localStorage.setItem('token', response.data.data.token);
          localStorage.setItem('user', user);
          this.$router.push('/');

        }else{
          this.$swal({
              icon: 'error',
              title: this.$t('common.loginFailed'),
              timer: 3000,
              showConfirmButton: false,


          });
        }
        this.disabled = false;
      }).catch(e => {
        console.error(e);
      })
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

  },


  mounted(){
    this.getCountriesCode();

    if( localStorage.getItem('IsLoggedIn') == 'true' ){
      this.$router.push('/')
    }

    // get old value if exist
    // let UUID = localStorage.getItem('keyForMacAndID');
    // if( UUID == null ){
    //   let randomID = Math.floor(Math.random()*100000);
    //   localStorage.setItem('keyForMacAndID' , randomID)
    //   UUID = localStorage.getItem('keyForMacAndID')
    // }


    
  // // get old value if exist
  //   let macAddress = localStorage.getItem('macAddress');
  //   if( macAddress == null ){
  //     let randomID = Math.floor(Math.random()*100000);
  //     localStorage.setItem('macAddress' , randomID)
  //     macAddress = localStorage.getItem('macAddress')
  //   }



    

    fetch('https://api.ipify.org?format=json')
    .then(response => response.json())
    .then(data => localStorage.setItem('macAddress', data.ip))
    .catch(error => console.error(error));


    fetch('https://api.ipify.org?format=json')
    .then(response => response.json())
    .then(data => localStorage.setItem('keyForMacAndID', data.ip))
    .catch(error => console.error(error));

    

    // localStorage.setItem('token', this.token)

    // console.log(this.token)

  },

  // created(){
  // },

  
};
</script>

<style lang="scss" scoped>
    $mainColor: #1ec2a8;
    .mainColor{
      color: $mainColor;
    }
.v-select {
  position: absolute;
  line-height: 1;
  left: 0;
  top: 0;
  height: 100%;
  .v-field__append-inner {
    padding-top: 12px;
  }
  .v-field--variant-filled {
    .v-field__overlay {
      background-color: unset;
    }
  }
}
</style>