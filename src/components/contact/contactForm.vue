<template>
  <section class="contactUSForm mt-4 mb-5">
    <div class="container">
        <h6 class="labeledSection fw-bold mb-3"> {{  $t('nav.contact')}}   </h6>


        <form ref="contactForm" class="contactForm mt-4" @submit.prevent="contactForm()">

            <div class="form-group mb-3">
                <label for="username"> {{ $t('contact.name') }} </label>
                <input required type="text" id="username" class="form-control" :placeholder="$t('contact.nameplc')" v-model="name" name="name">
            </div>

            <div class="form-group mb-3">
                <label for="phone"> {{ $t('contact.phone') }} </label>
                    <div class="d-flex position-relative">
                        <input required type="number" id="phone" class="form-control" :placeholder="$t('contact.phoneplc')" v-model="phone" name="phone">
                        <v-select  :items="items" v-model="country_key" name="country_key" class="position-absolute" style="left:0"></v-select>
                    </div>
                    

            </div>

            <div class="form-group mb-3">
                <label for="subject"> {{ $t('contact.subject') }} </label>
                <input required type="text" id="subject" class="form-control" :placeholder="$t('contact.subject')" v-model="subject" name="subject">
            </div>
            

            <div class="form-group mb-3">
                <label for=""> {{ $t('contact.message') }} </label>
                <textarea required :placeholder="$t('contact.messageplc')" class="form-control" v-model="message" name="message"></textarea>
            </div>

            <div class="d-flex justify-center mx-auto">
                <button class="main_btn up" :disabled="disabled"> {{$t('contact.send')}} </button>
            </div>
        </form>
    </div>
  </section>
</template>

<script>
import axios from 'axios'
export default {
    data(){
        return{
            disabled : false,
            items : [],
            country_key : null
        }
    },
    methods:{
        async contactForm(){
            this.disabled = true
            await axios.post(  'contact-us', this.$refs.contactForm )
            .then( (res)=>{
                if( res.data.key=="success" && res.data.code== 200 ){
                    this.$swal({
                        icon: 'success',
                        title: res.data.msg,
                        timer : 2000
                    });
                }else{
                    this.$swal({
                        icon: 'error',
                        title: res.data.msg,
                        timer : 2000
                    });
                }

                this.disabled = false
            } )
            .catch( (err)=>{
                console.err(err)
            } )
        },
        // get countryCode 
        async getCountriesCode(){
        await axios.get('countries')
        .then( (response)=>{
            // this.items = response.data.data.countries;
            for( let i = 0 ; i < response.data.data.countries.length ; i++){
                this.items.push(response.data.data.countries[i].calling_code)
            }
        } )
        },
    },
    mounted(){
        this.getCountriesCode()
    }
}
</script>

<style lang="scss" scoped>
    .contactForm{
        width: 55%;
        margin: auto;
        label{
            font-size: 18px;
            font-weight: 600;
            display: block;
            margin-bottom: 12px;
        }
        input, select{
            height: 55px;
            border: 1px solid #918181;
            background-position: left 0.75rem center;
            &::placeholder{
                color: #333 ;
            }
        }
        select{
            padding: .375rem 1rem .375rem .75rem;
        }
        textarea{
            height: 100px;
            border: 1px solid #918181;

        }
    }
</style>