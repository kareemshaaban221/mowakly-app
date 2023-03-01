<template>
  <section class="statistic mt-5 mb-5">
    <div class="container">
        <h3 class="fw-bold text-center"> {{ $t('common.appStats') }} </h3>
        <p class="text-center text-muted smallText"> {{ $t('common.statisText') }} </p>

        <div class="statis d-flex justify-content-between mt-3">

            <div class="d-flex flex-column justify-content-center align-items-center singleStas">
                <h5 class="fw-bold stasTitle"> + {{ clients }} </h5>
                <p> {{ $t('common.clients') }} </p>
            </div>

            <div class="d-flex flex-column justify-content-center align-items-center singleStas">
                <h5 class="fw-bold stasTitle"> + {{ stores }} </h5>
                <p> {{ $t('common.stores') }} </p>
            </div>

            <div class="d-flex flex-column justify-content-center align-items-center singleStas">
                <h5 class="fw-bold stasTitle"> + {{ downloads }} </h5>
                <p>{{ $t('common.downloads') }}</p>
            </div>

        </div>
    </div>
  </section>
</template>

<script>
export default {
    props:{
        stores : Number,
        downloads : Number,
        clients : Number,
    }
}
</script>

<style lang="scss" scoped>
.smallText{
    font-size: 12px;
}
.statis{
    .singleStas{
        width:70%;
        margin: auto;
        .stasTitle{
            color: #066c6b;
            font-size: 26px;
        }
        p{
            font-weight: 600;
        }
    }
}
</style>