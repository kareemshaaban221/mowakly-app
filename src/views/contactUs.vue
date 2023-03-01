<template>
    <!-- header  -->
    <pageHeader />

    <!-- contact form  -->
    <contactUSForm />

    <!-- download app  -->
    <downloadApp />

    <!-- footer  -->
    <pageFooter />
</template>

<script>
import pageHeader from '../components/home/pageHeader.vue'
import pageFooter from '../components/home/pageFooter.vue'
import contactUSForm from '../components/contact/contactForm.vue'
import downloadApp from '../components/about/downloadApp.vue'
export default {
    components:{
        pageFooter,
        pageHeader,
        contactUSForm,
        downloadApp
    }
}
</script>

<style>

</style>