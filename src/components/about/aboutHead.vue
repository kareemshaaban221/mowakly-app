<template>
    <section class="about_head mt-4 mb-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h6 class="labeledSection fw-bold mb-3"> {{  $t('nav.who')}}  </h6>
                    <p class="fw-6">
                        {{ whous }}
                    </p>
                </div>

                <div class="col-md-6">
                    <div>
                        <img :src="src" alt="" class="about_image">
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
export default {
    data(){
        return{
            src : require('../../assets/logo2.png')
        }
    },
    props:{
        whous  : String
    }
}
</script>

<style>
    .fw-6{
        font-weight: 500;
        color: #000;
    }
    .about_image{
        width: 290px;
        height: 200px;
        margin: auto;
        display: flex;
        object-fit: contain;
    }
</style>