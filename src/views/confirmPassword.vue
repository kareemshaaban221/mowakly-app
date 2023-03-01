<template>
    <div class="login-body">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <confirmPasswordForm />
          </div>
          <div class="col-md-6">
            <LoginWrapper :titleAuth="$t('auth.resetPassword')" />
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import LoginWrapper from "../components/auth/LoginWrapper.vue";
  import confirmPasswordForm from "../components/auth/confirmPasswordForm.vue";
  
  
  export default {
    name: "HomeLogin",
  
    components: {
      LoginWrapper,
      confirmPasswordForm,
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
  