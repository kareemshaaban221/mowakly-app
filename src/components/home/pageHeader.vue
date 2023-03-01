<template>
  <header>

    <section>
        <div class="container">

            <!-- slider  -->
            <PageSlider :sliders="sliders" />

            <!-- nav bar  -->
            <section class="NavBar pt-4 mb-5 d-flex justify-content-between align-items-center  ">

              <!-- toggle navbar -->
              <div class="hamburger" @click="toggleNav()" ref="hamburgar">
                <div class="line1"></div>
                <div class="line2"></div>
                <div class="line3"></div>
              </div>

              <!-- logo  -->
              <div id="logo">
                  <img :src="src" alt="">
              </div>

              <!-- navbar -->
              <nav class="navbar navbar-expand-lg navbar-light navSmallScreen" ref="navSmallScreen">
                <div class="" id="navbarSupportedContent">
                  <ul class="navbar-nav mr-auto flex-row">

                    <li class="nav-item">
                      <router-link to="/" class="nav-link" :class="{active : $route.path === '/'}"> {{  $t('nav.home')}} </router-link>
                    </li>

                    <li class="nav-item">
                      <router-link to="/stores" class="nav-link" :class="{ active : $route.path === '/stores' }"> {{  $t('nav.stores')}} </router-link>
                    </li>

                    <li class="nav-item">
                      <router-link to="/offers" class="nav-link" :class="{ active: $route.path === '/offers' }"> {{  $t('nav.offers')}} </router-link>
                    </li>

                    <li class="nav-item">
                      <router-link to="/favorites" class="nav-link" @click="loginAlert()"  :class="{ active : $route.path === '/favorites' }"> {{  $t('nav.favs')}} </router-link>
                    </li>

                    <li class="nav-item">
                      <router-link to="/about-us" class="nav-link" :class="{ active : $route.path === '/about-us' }"> {{  $t('nav.who')}} </router-link>
                    </li>

                    <li class="nav-item">
                      <router-link to="/ContactUs" class="nav-link" :class="{ active : $route.path === '/ContactUs' }"> {{  $t('nav.contact')}}   </router-link>
                    </li>


                  </ul>

                </div>
              </nav>

              <section class="userGrouped d-flex justify-content-between">

                <!-- user icons  -->
                <div class="userAction d-flex">

                  <!-- location  -->
                  

                  <googleMap @update:latLng="getClientInfo" />

                  <!-- alerts  -->
                  <router-link to="/NotificationPage" class="alert_Icon" @click="loginAlert()">
                    <i class="fa-solid fa-bell"></i>
                    <span class="alert_cont" v-if="user"> {{ cloudNoti }} </span>
                    <span class="alert_cont" v-else> 0</span>
                  </router-link>

                </div>

                <!-- profile dropdown  -->
                <div class="dropdown" v-if="user">
                  <button class="btn dropdown-toggle d-flex justify-content-between align-items-center" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                    
                    <img :src="src" alt="profile">
                    <span> {{ username }} </span>
                    <i class="fa-solid fa-chevron-down"></i>

                  </button>
                  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">

                    <li class="first_drop">

                      <router-link class="dropdown-item" to="/profile">
                        <i class="fa-regular fa-user"></i>
                        <span>{{  $t('nav.account')}}</span>
                      </router-link>
                      
                    </li>

                    <li>
                      <button class="dropdown-item btn" @click="signOut()" style="color:#333">
                        <i class="fa-solid fa-right-from-bracket"></i>
                        <span>{{  $t('nav.logout')}}</span>
                      </button>

                    </li>

                  </ul>
                </div>

                <div v-else> 
                  <router-link to="/HomeLogin" class="login"> {{ $t('auth.login') }} </router-link>
                </div>

              </section>
              
            </section>

            <!-- search bar  -->
            <searchBar />

        </div>
    </section>

  </header>
</template>

<script>
import PageSlider from './PageSlider.vue';
import googleMap from './googleMap.vue';

import searchBar from '../share/sreachBarCates.vue'
import axios from 'axios'
export default {
    data(){
      return{
        src : require('../../assets/logoz.png'),

        // search categories array 
        dialog: false,
        latLng : { lat : 0 , lng : 0},
        user : {},
        username : '',
        noti_count  : null,
        cloudNoti : null ,
        loginSwitch : ''
    }
    },
    components:{
      PageSlider,
      googleMap,
      searchBar
    },
    methods:{

      toggleNav(){

        const hamburger = this.$refs.hamburgar;
        const navLinks = this.$refs.navSmallScreen
        const links = document.querySelectorAll(".navSmallScreen li");


        //Animate Links
        navLinks.classList.toggle("open");
        links.forEach(link => {
            link.classList.toggle("fadee");
        });

        //Hamburger Animation
        hamburger.classList.toggle("toggle");

      },

      // get user lat and lng 
      getClientInfo(latLng){
        this.latLng = latLng
      },

      // logout 
      async signOut(){
        await axios.post('logout', {
          device_id : localStorage.getItem('keyForMacAndID')
        },{
          headers : {
                Authorization:  `Bearer ${localStorage.getItem('token')}`
          }
        } 
        
        )
        .then( (res)=>{
          if( res.data.code == 200 && res.data.key == "success" ){
            this.$swal({
              icon: 'success',
              title: res.data.msg,
              timer : 2000,
              showConfirmButton: false,

            });
              localStorage.removeItem('user');

              localStorage.removeItem('token');

              this.$router.push('/HomeLogin');

              localStorage.setItem('IsLoggedIn', false);

          }else{
            this.$swal({
              icon: 'error',
              title: res.data.msg,
              timer : 2000,
              showConfirmButton: false,
            });
          }
        } )
      },

      // get notification count 
      async getNotUnSee(){
        await axios.get('unseen-notifications-count',{
          headers : {
                Authorization:  `Bearer ${localStorage.getItem('token')}`
          }
        } 
        
        )
        .then( (res)=>{
          this.noti_count = res.data.data.num_not_seen_notifications

          localStorage.setItem('noticount', this.noti_count)
        } )
        .catch( (err)=>{
          console.log(err)
        } )
      },

      // login alert if not login 
      loginAlert(){
        // let isLoggedIn = localStorage.getItem('IsLoggedIn')
        if( this.isLoggedIn  === 'false' ){
          this.$swal({
              icon: 'error',
              title: this.$t('common.pleaseLogin'),
              timer: 2000,
              showConfirmButton: false,
          });
        }

        
      }
      
    },

    computed:{
      isLoggedIn() {
        return localStorage.getItem('IsLoggedIn')
      }

    },


    // updated(){
    // },
    created(){
      this.user = localStorage.getItem('user');
      if(this.user){
        this.username = JSON.parse(localStorage.getItem('user')).name.split(' ')[0]

        
      }else{
        return null
      }

      if( localStorage.getItem('updatedUserName') && localStorage.getItem('isUserNameUpdated')=="true" ){
          this.username = localStorage.getItem('updatedUserName')
      }

      console.log(this.username)
    },
    props:{
      sliders : Array
    },
    beforeMount(){
            this.getNotUnSee();

    },
    mounted(){
      this.getClientInfo();
      this.cloudNoti = localStorage.getItem('noticount')
    },
    





    
}
</script>

<style lang="scss">
$base-color: #1ec2a8;

header{
  position: relative;
  height: 47vh;
  .dropdown-toggle{
    padding: 0;
  }
  .NavBar{
    background-color: $base-color;
    #logo{
      position: relative;
      img{
          width: 165px;
          height: 110px;
          object-fit: contain;
      }
    }
    .nav-item{
      margin-right: 9px;
      margin-left: 9px;
        .nav-link{    
          position: relative;
          color: #fff !important;
          font-size: 18px;
          &::before{
            content: '';
            position: absolute;
            width: 0%;
            height:2px;
            right:0;
            bottom: -4px;
            background-color: #1ec2a8;
            transition: .4s all;
          }
          &:hover::before , &.active::before{
            width: 100%;
          }
      }
    }
    .userAction{
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin : 0 25px;
      button{
        box-shadow: none;
      }
      svg{
        position: relative;
        color: #fff !important;
        font-size: 20px;
        margin: 0 9px;
      }
      .alert_Icon{
        position: relative;
        .alert_cont{
          position: absolute;
          background-color: #1ec2a8;
          width: 18px;
          height: 18px;
          border-radius: 50%;
          color: #fff;
          top: -5px;
          font-size: 11px;
          right: 1px;
          text-align: center;
        }
      }
    }
    .dropdown{
      .dropdown-toggle::after{display: none;}
      .btn{
        color: #fff;
        font-size: 18px;
        img{
          width: 30px;
          height: 30px;
          border-radius: 50%;
          object-fit: cover;
          margin: 0 9px;
        }
        svg{
          margin: 0 9px;
        }
      }
      .dropdown-item{
        display: flex;
        justify-content: start;
        align-items: center;
        font-size: 18px;
        svg{
          margin: 0 5px;
        }
      }
      .first_drop{
        border-bottom: 1px solid rgb(202, 196, 196);
      }
    }
  }
  .v-field--variant-filled .v-field__overlay{ background-color: #fff !important; opacity: 1; }
  .v-field__append-inner{ display: none; }
  .v-field--variant-filled:hover .v-field__overlay , .v-field--variant-filled.v-field--focused .v-field__overlay{ opacity: 1; }
  .v-input--horizontal{
      position: relative;
      .v-label.v-field-label{
        color: #197776;
        opacity: 1;
        
      }
  }
  .searchBar{
    position: relative;
    width: 68%;
    margin: auto;
    .v-field{
      border-radius: 8px;
      height: 50px;
    }
    svg{
      position: absolute;
      left: 18px;
      top: 25%;
      font-size: 20px;
      color: #197776

    }
  }

  /*Styling Hamburger Icon*/
  .hamburger div {
      width: 25px;
      height: 3px;
      background: #197776;
      margin: 5px;
      transition: all 0.3s ease;
  }

  .hamburger {
      display: none;
  }

  /*Animating Hamburger Icon on Click*/
  .toggle .line1 {
      transform: rotate(-45deg) translate(-5px, 6px);
  }

  .toggle .line2 {
      transition: all 0.7s ease;
      width: 0;
  }

  .toggle .line3 {
      transform: rotate(45deg) translate(-5px, -6px);
  }
}

</style>

<!-- responsive --> 
<style scoped>
.login{
    color: white;
    z-index: 99;
    position: relative;
    font-size: 18px;
    margin:0 12px;
}
@media( max-width : 991.98px ){
    .userGrouped{
      position: fixed;
      bottom: 0;
      left: 0;
      z-index: 9;
      width:100%;
      background-color: #1ec2a8;
      padding: 5px 0;
      border-top-right-radius: 10px;
      border-top-left-radius: 10px;
    }
    header .NavBar #logo img{
      width: 85px;
      height:85px; 
    }
   .hamburger{
        display: block;
        position: relative;
        cursor: pointer;
        z-index: 4;
        transition: all 0.7s ease;
    }
    .navSmallScreen{
        position: fixed;
        background: #131418e3;
        height: 100vh;
        width: 100%;
        flex-direction: column;
        clip-path: circle(50px at 90% -20%);
        -webkit-clip-path: circle(50px at 90% -10%);
        transition: all 1s ease-out;
        pointer-events: none;
        z-index: 2;
        right: 0;
        top: 0;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .navbar-nav{
      flex-direction: column !important;      
    }
    .navSmallScreen.open{
        clip-path: circle(1000px at 90% -10%);
        -webkit-clip-path: circle(1000px at 90% -10%);
        pointer-events: all;
    }
    .navSmallScreen li{
        opacity: 0;
    }
    .navSmallScreen li:nth-child(1){
        transition: all 0.5s ease 0.2s;
    }
    .navSmallScreen li:nth-child(2){
        transition: all 0.5s ease 0.4s;
    }
    .navSmallScreen li:nth-child(3){
        transition: all 0.5s ease 0.6s;
    }
    .navSmallScreen li:nth-child(4){
        transition: all 0.5s ease 0.7s;
    }
    .navSmallScreen li:nth-child(5){
        transition: all 0.5s ease 0.8s;
    }
    .navSmallScreen li:nth-child(6){
        transition: all 0.5s ease 0.9s;
        margin: 0;
    }
    .navSmallScreen li:nth-child(7){
        transition: all 0.5s ease 1s;
        margin: 0;
    }
    li.fadee{
        opacity: 1;
    }
}
</style>