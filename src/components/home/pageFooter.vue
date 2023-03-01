<template>
  <footer class=" pt-5" id="footer">
    <div class="container">
      <div class="row">

        <div class="col-md-4">
            <h6 class="labeledSection  mb-4"> {{ $t('footer.about') }} </h6>

            <div class="main_links d-flex flex-column mt-3">
              <router-link to="/about-us"> {{ $t('footer.WhoWe') }} </router-link>
              <router-link to="/profile"> {{ $t('footer.conditions') }} </router-link>
              <router-link to="/profile"> {{ $t('footer.commonQues') }} </router-link>
              <router-link to="/ContactUs"> {{ $t('footer.contactUS') }} </router-link>
            </div>
        </div>


        <div class="col-md-4">
            <h6 class="labeledSection  mb-4"> {{ $t('footer.callUs') }} </h6>

            <div class="contactUs mt-3">


              <v-dialog
                  v-model="dialog"
                  width="70%"
              >
                  <template v-slot:activator="{ on, attrs }">
                    <button
                        class="btn p-0"
                        v-bind="attrs"
                        v-on="on"
                        @click="dialog = true"
                    >
                        <div class="d-flex align-items-baseline">
                            <img :src="location" alt="" class="location">
                            <p class="fw-600"> {{ webData.address }} </p>
                          </div>
                    </button>
                  </template>

                  <v-card class="px-4 pt-5">

                  <div class="d-flex justify-content-end mb-4">
                      <button class="btn btn-danger closeMapModal" @click="dialog = false" >
                      <i class="fa-solid fa-x"></i>
                      </button>
                  </div>

                  <!-- google map  -->
                  <GoogleMap
                      api-key="AIzaSyB4d19CAL7u_hJ8k4P7EaQFcnner_Q9KEo"
                      style="width: 100%; height: 500px"
                      :center="center"
                      :zoom="15"
                  >
                      <Marker :options="markerOptions" />
                  </GoogleMap>


                  <v-card-actions class="mx-auto mt-4 mb-4">
                      <v-spacer></v-spacer>
                      <button
                      class="main_btn up"
                      text
                      @click="dialog = false"
                      >
                      {{ $t('common.confirm') }}
                      </button>
                  </v-card-actions>
                  </v-card>
              </v-dialog>

              <a :href="'tel:'+webData.phone" class="d-flex align-items-baseline">
                <img :src="tel" alt="" class="tel">
                <p class="fw-600"> {{ webData.phone }} </p>
              </a>

              <a :href="'mailto:'+webData.email" class="d-flex align-items-baseline">
                <img :src="mail" alt="" class="mail">
                <p class="fw-600"> {{ webData.email }} </p>
              </a>

              <!-- social media  -->
              <div class="soicalMedia d-flex justify-start align-items-center">
                <div v-for="soical in socials" :key="soical.id">
                  <a :href="soical.link">
                    <img :src="soical.image" :alt="soical.name" class="socail_media_img">
                  </a>
                </div>

              </div>

            </div>
        </div>

        <div class="subscription col-md-4 ">
            <h6 class="labeledSection  mb-4"> {{ $t('footer.email') }} </h6>

            <div class="form-group">
              <form @submit.prevent="subscribe()" ref="subscribeUser">
                <label for="" class="follow_us">{{ $t('footer.followUs') }}</label>

                <input type="text" name="email" v-model="email" class='form-control' :placeholder="$t('footer.email')">

                <v-btn
                  elevation="2"
                  class="button w-50"
                  :disabled="disabled"
                  type="submit"
                > {{ $t('footer.sub') }} </v-btn>
              </form>
            </div>
        </div>

      </div>

      <!-- download app  -->
      <div class="downloadApp mt-3">
        <h6>  {{ $t('footer.download') }} </h6>
        <div class="d-flex">
          <a :href="webData.ios_link">
            <img :src="appStore" alt="">
          </a>

          <a :href="webData.android_link">
            <img :src="googlePlay" alt="">
          </a>
        </div>
      </div>

      <!-- copy right  -->
      <div class="copyRight d-flex justify-content-between mt-4">
        <p> {{ $t('footer.copyRight') }} </p>
        <p> {{ $t('footer.desin') }} <a href="https://aait.sa/"> {{ $t('footer.awamer') }} </a> </p>
      </div>
    </div>
  </footer>
</template>

<script>
import axios from 'axios'
import { GoogleMap, Marker } from 'vue3-google-map';

export default {
  data(){
    return{
      location : require('../../assets/location.png'),
      tel : require('../../assets/tele.png'),
      mail : require('../../assets/mail.png'),
      face : require('../../assets/facebook.png'),
      googlePlay : require('../../assets/googlePlay.png'),
      appStore : require('../../assets/appStore.png'),
      webData : {},
      socials : [],
      dialog : false,
      disabled : false
    }
  },
  components:{
    GoogleMap, Marker
  },
  setup() {
      const center = { lat: 0, lng: 0 }
      const markerOptions = { position: center, label: 'L', title: 'LADY LIBERTY' }

      return { center, markerOptions }
  },
  methods:{
    async getWebInfo(){
      await axios.get(`web-info`)
      .then( (res)=>{
        this.webData = res.data.data

        this.center.lat = parseFloat(res.data.data.lat)
        this.center.lng = parseFloat(res.data.data.long)

      } )
    },

    async getSoicals(){
      await axios.get(`socials`)
      .then( (res)=>{
        this.socials = res.data.data.socials
      } )
    },

    async subscribe(){
      this.disabled = true
      const fd = new FormData()
      fd.append('email', this.$refs.subscribeUser)
      await axios.post('subscribe-us', fd)
      .then( (res)=>{
        if( res.data.key == "success" && res.data.code == 200 ){
          this.$swal({
              icon: 'success',
              title: res.data.msg,
              timer: 3000,
              showConfirmButton: false,
              animation : true
          });
          this.disabled = false
        }
      } )
    }

    // geolocation () {
    //     navigator.geolocation.getCurrentPosition((position) => {
    //       this.center = {
    //         lat: position.coords.latitude,
    //         lng: position.coords.longitude,
    //       };
    //       this.markerOptions = { position : this.center, label: 'L', title: 'Your Location' }

    //       localStorage.setItem('lat',this.center.lat );
    //       localStorage.setItem('lng',this.center.lng );
    //     });
    //   },

  },
  mounted(){
    this.getWebInfo()
    this.getSoicals()

    // console.log(this.webData.lat)

  }
}
</script>

<style lang="scss">
    $base-color: #1ec2a8;

  footer{
    background-color: #f5f5f5;
    margin-top: 60px !important;
    .labeledSection{
      color:#1ec2a8;
      font-weight: normal;
    }
    .main_links{
      a{
        color:#111;
        margin-bottom: 12px;
      }
    }
    .contactUs{
      img{
        margin: 0 4px;
      }
      .location{
        width: 14px;
        height: 20px;
      } 
      .tel{
        width:18px;
      }
      .mail{
        width:21px;
      }
      a{
        color:#111;
      }
      .fw-600{
        font-weight: 600;
      }
      .socail_media_img{
        width:30px;
        height:30px;
        border-radius: 50%;
        margin-left: 9px;
      }
    }
    .subscription{
      label{
        color: gray;
        font-size: 11px;
        margin-bottom: 12px;
      }
      input{
        border: 1px solid #1ec2a8;
        font-size: 12px;
        height:40px;
      }
      button{
        margin-top: 12px;
        color:#fff !important;
      }
    }

    .copyRight{
      p{
        font-size: 15px;
        font-weight: 600;
      }
      a{
        color:#111
      }
    }
  }

    .downloadApp{
      img{
        width: 190px;
        height: 67px;
        object-fit: contain;
        margin-left: 12px;
      }
    }
    @media(max-width:768px){
      .downloadApp div{
        flex-direction: column;

      }
      .downloadApp div a{
        display: flex;
        justify-content: center;
        margin-bottom: 12px;
      }
      #footer{
        padding-bottom: 40px;
      }
      .copyRight {
        flex-direction: column;
        align-items: center;
      }
      .checks {
        flex-wrap: wrap;
      }
      .storeDetails .follow_store{
          top: -42px !important;
          width: 100% !important;
          left: -25px !important;
      }
      .storeDetails .follow_store svg, .storeDetails .follow_store span{font-size: 15px !important;}
      .offer_details_header{
        flex-direction: column;
      }
      .statis {
        flex-direction: column;
      }
      .dowloadApp .dowloadPhone {
          width: 289px !important;
          height: 300px !important;
          margin-top: 81px !important;
      }
      .dowloadApp .dowloadPhone img{
          width: 230px;
          height: 352px;
          -o-object-fit: contain;
          object-fit: contain;
      }
      .dowloadApp h1{
        font-size: 22px !important;
      }
      .contactForm{
        width: 95% !important;
      }
      .accordion-button h5{
        font-size: 18px !important;
      }
    }
</style>