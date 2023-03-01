<template>
  <div class="login-body">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <forgitForm />
        </div>
        <div class="col-md-6">
          <LoginWrapper titleAuth="نسيت كلمة المرور" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import LoginWrapper from "../components/auth/LoginWrapper.vue";
import forgitForm from "../components/auth/forgitForm.vue";


export default {
  name: "HomeLogin",

  components: {
    LoginWrapper,
    forgitForm,
  },
};
</script>

<style lang="scss">
.login-body {
  height: 100vh;
  overflow: auto;
  .container {
    height: 100%;
    .row {
      height: 100%;
    }
  }
}
</style>
