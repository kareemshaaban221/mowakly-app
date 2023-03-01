<template>
  <div class="login-body">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <LoginForm />
        </div>
        <div class="col-md-6">
          <LoginWrapper :titleAuth="$t('auth.login')" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import LoginForm from "../components/auth/LoginForm.vue";
import LoginWrapper from "../components/auth/LoginWrapper.vue";

export default {
  name: "HomeLogin",

  components: {
    LoginForm,
    LoginWrapper,
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
