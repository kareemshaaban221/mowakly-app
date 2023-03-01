<template>
  <div class="login-body">
    <div class="container">
      <div class="row">
        <div class="col-12" style="min-height: 230px;">
          <LoginWrapper :titleAuth="$t('auth.signup')" />
        </div>
        <div class="col-12">
          <div class="row justify-content-center">
            <div class="col-md-6 col-12">
                <regesterForm />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import regesterForm from "../components/auth/regesterForm.vue";
import LoginWrapper from "../components/auth/LoginWrapper.vue";

export default {
  name: "HomeLogin",

  components: {
    regesterForm,
    LoginWrapper,
  },
};
</script>

<style lang="scss">
</style>
