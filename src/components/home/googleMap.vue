<template>
    <section class="googleMap">
      <v-dialog
        v-model="dialog"
        width="70%"
    >
        <template v-slot:activator="{ on, attrs }">
        <v-btn
            color="transparent lighten-2"
            dark
            v-bind="attrs"
            v-on="on"
            @click="dialog = true"
        >
            <i class="fa-solid fa-location-dot"></i>
        </v-btn>
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
    </section>
</template>

<script>
import { GoogleMap, Marker } from 'vue3-google-map';

export default {
    data(){
        return{
            dialog: false,
            // lat : 0,
            // long : 0,
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
      geolocation () {
        navigator.geolocation.getCurrentPosition((position) => {
          this.center = {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          };
          this.markerOptions = { position : this.center, label: 'L', title: 'Your Location' }

          localStorage.setItem('lat',this.center.lat );
          localStorage.setItem('lng',this.center.lng );
        });
      },

    },

    mounted(){
    },
    updated(){      
      this.geolocation();
      console.log(this.center.lat)
      console.log(this.center.lng)
    }
  }
</script>

<style scoped>
.closeMapModal{
    border-radius: 50% !important;
    width: 30px;
    height: 30px;
    /* float: none; */
    display: flex !important;
    justify-content: center;
    align-items: center;
}


</style>