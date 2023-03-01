<template>
  <div>
    <form ref="otpInputForm" @submit.prevent="submitForm">
      <div class="d-flex align-items-center flex-column">
        <v-img
          lazy-src="@/assets/logoz.png"
          height="200"
          width="200"
          src="@/assets/logoz.png"
        ></v-img>

        <h2 class="fontBold">{{ $t('auth.wellcome') }}</h2>

        <p class="fontBold">{{ $t('auth.dataConfirm') }}</p>
      </div>
      <div class="d-flex align-items-center justify-content-center">
        <v-otp-input
          ref="otpInput"
          input-classes="otp-input"
          separator=" "
          :num-inputs="6"
          :should-auto-focus="true"
          v-modal="otpInput"
          name="otpInput"
          :is-input-num="true"
          @on-change="handleOnChange"
          @on-complete="handleOnComplete"
        />
      </div>
      <div class="mt-3 mb-3 d-flex justify-content-center">
        <button class="main_btn up" :disabled="disabled">{{ $t('auth.confirm') }}</button>
      </div>
    </form>
  </div>
</template>

<script>
import axios from "axios";
// Import in a Vue component
import VOtpInput from "vue3-otp-input";

export default {
  data(){
    return{
      disabled : false
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
    async submitForm(){

      this.disabled = true
      const formData = new FormData()

      //convert otp array to a string then to a number
      let otpString = JSON.stringify(this.$refs.otpInput.otp.join(""));
      let otpsNumber = JSON.parse(otpString)


      formData.append('code', otpsNumber);


      console.log(otpsNumber);
      await axios.post(
        `account/activation`,formData,{
            headers : {
                Authorization:  `Bearer ${localStorage.getItem('token')}`
            }
        },
        
      ).then((response) => {
        if(response.status == 200 && response.data.key == "success"){
          this.$swal({
              icon: 'success',
              title: this.$t('common.activeAcc'),
              timer:2000,
              showConfirmButton: false,
          });

          this.$router.push('/')
        }else{
          this.$swal({
              icon: 'error',
              title: response.data.msg,
              timer:2000,
              showConfirmButton: false,
          });
        }

        this.disabled = false
      }).catch(e => {
        console.error(e);
      })
    }
  }
};
</script>

<style lang="scss">
$base-color: #1ec2a8;

.position-relative {
  position: relative;
}
.otp-input {
  width: 40px;
  height: 40px;
  padding: 5px;
  margin: 0 10px;
  font-size: 20px;
  border-radius: 4px;
  border: 1px solid rgba(0, 0, 0, 0.3);
  text-align: center;
  &:focus{
    border: 1px solid $base-color;
  }
}

.otp-input.is-complete {
    background-color: #f1f1f1;
    border: 1px solid #f1f1f1;
}
.otp-input::-webkit-inner-spin-button,
.otp-input::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
input::placeholder {
  font-size: 15px;
  text-align: right;
  font-weight: 600;
}
</style>
