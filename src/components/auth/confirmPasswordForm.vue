<template>
  <div>
    <form ref="confirmPasswordForm" @submit.prevent="submitForm">
      <div class="d-flex align-items-center flex-column">
        <v-img
          lazy-src="../../assets/logoz.png"
          height="200"
          width="200"
          src="../../assets/logoz.png"
        ></v-img>

        <h2 class="fontBold">{{ $t("auth.wellcome") }}</h2>

        <p class="fontBold">{{ $t("auth.dataChangePass") }}</p>
      </div>
      <div class="mt-3 mb-3">
        <h6 class="fontBold mb-0">{{ $t("auth.password") }}</h6>
        <div class="form__label">
          <input
            class="default_input"
            name="password"
            :type="typePass"
            v-model="password"
            required=""
            placeholder="{{ $t('auth.insert') }} {{ $t('auth.password') }}"
          />
          <label class="float__label" for=""
            >{{ $t("auth.insert") }} {{ $t("auth.password") }}</label
          >
          <span class="icon-input">
            <v-img
              lazy-src="../../assets/Unlock.png"
              height="25"
              width="25"
              src="../../assets/Unlock.png"
            ></v-img>
          </span>
          <v-btn
            class="float_btn"
            color="white"
            elevation="0"
            small
            type="button"
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

      <div class="mt-3 mb-3">
        <h6 class="fontBold mb-0">{{ $t("auth.confirmPassword") }}</h6>
        <div class="form__label">
          <input
            class="default_input"
            name="password_confirmation"
            :type="typePassConfrm"
            v-model="password_confirmation"
            required=""
            placeholder="{{ $t('auth.insert') }} {{ $t('auth.confirmPassword') }}"
          />
          <label class="float__label" for=""
            >{{ $t("auth.insert") }} {{ $t("auth.confirmPassword") }}</label
          >
          <span class="icon-input">
            <v-img
              lazy-src="../../assets/Unlock.png"
              height="25"
              width="25"
              src="../../assets/Unlock.png"
            ></v-img>
          </span>
          <v-btn
            class="float_btn"
            color="white"
            elevation="0"
            small
            type="button"
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
      <div class="mt-3 mb-3 d-flex justify-content-center">
        <button class="main_btn up" color="#1ec2a8" elevation="0" x-large :disabled="disabled">
          {{ $t("auth.confirm") }}
        </button>
      </div>
    </form>
  </div>
</template>
  
  <script>
import axios from "axios";
export default {
  data: () => ({
    items: ["+996", "+20", "565", "+10"],
    password_confirmation: "",
    password: "",
    typePass: "password",
    typePassConfrm: "password",

    disabled : false
  }),
  methods: {
    showPassword() {
      this.typePass = this.typePass === "password" ? "text" : "password";
    },
    confrmPassword() {
      this.typePassConfrm =
        this.typePassConfrm === "password" ? "text" : "password";
    },

    async submitForm() {
      this.disabled = true
      const formData = new FormData(this.$refs.confirmPasswordForm);
      formData.append('phone', localStorage.getItem('phone'))
      await axios
        .post(`password/reset`, formData)
        .then((response) => {
          if (response.status == 200 && response.data.key == "success") {
            this.$swal({
                icon: 'success',
                title: response.data.msg,
                timer:2000,
              showConfirmButton: false,
            });

            this.$router.push('/HomeLogin')

          }else{
            this.$swal({
                icon: 'error',
                title: response.data.msg,
                timer:2000,
              showConfirmButton: false,
            });
          }

          this.disabled = false
        })
        .catch((e) => {
          console.error(e);
        });
    },
  },
};
</script>
  
  <style lang="scss" scoped>
</style>
  