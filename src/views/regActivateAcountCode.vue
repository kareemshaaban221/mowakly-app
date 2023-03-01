<template>
     <div class="login-body">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <activeAccount />
        </div>
        <div class="col-md-6">
          <LoginWrapper titleAuth="تفعيل الحساب" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import activeAccount from '../components/auth/activeAcount.vue'
import LoginWrapper from "../components/auth/LoginWrapper.vue";

export default {
    components:{
        activeAccount,
        LoginWrapper
    }
}
</script>

<style>

</style>