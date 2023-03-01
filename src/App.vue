<template>
      <router-view v-slot="{ Component, route }">
        <transition name="fade" mode="out-in" >
          <div :key="route.name">
              <component :is="Component"></component>
          </div>
        </transition>  
        <v-snackbar
          v-model="snackbar"
          class="notificationAlert"
        >
          <router-link to="/NotificationPage">
            <div class="title">
              {{ this.toastTitle }}
            </div>
            <div class="body">
              {{ this.toastBody }}
            </div>
          </router-link>
        </v-snackbar>
      </router-view> 
</template>

<script>
// english style 
import "../src/assets/css/ltr.scss";

// import messaging config from firebase.js file and firebase/messaging module 
import {messaging} from './firebase'
import {getToken , onMessage }  from "firebase/messaging"

import axios from 'axios'
export default {
  name: "App",

  data: () => ({
    //options api
    // provide: {
    //   messaging: firebaseMessaging
    // }
    token : null,
    user : null,
    toastTitle : '',
    toastBody : '',
    snackbar : false,
    notifiCount : null

  }),

  methods:{

    // regenerate notification count 
    async notiCount(){
      await axios.get('unseen-notifications-count',{
        headers :{
            Authorization:  `Bearer ${localStorage.getItem('token')}`
        }
      })
      .then( (res)=>{
        this.notiCount = res.data.data.num_not_seen_notifications
        localStorage.setItem('noticount', this.notiCount)
      } )
    },

    // making request permission to ask user to accept Notification  
    async requestPermission(){
      const permission = await Notification.requestPermission()
      if( permission === "granted" ){
        // Generate token
        // we get the token from project setting => cloud messaging => generateKey
        getToken( messaging , {vapidKey:"AAAACCt-uuw:APA91bGRrYAXQ1DWg-yUvG284ltH-qXk0b3jHpH_btyELFcMcIJtgTu2L_l4XRDEpDihTyPtu012gGrWHiGrT20KIZVRCOoNkb37GXlfHME3_jvDf6vPWLyr4SenVhUYCbd0Jt1-q1Ho"} )
        // {vapidKey:"BFpjV9Ma8fIm3fnaCxRZMuQM_iPkZcyUpmje05C7sG-S7K7MNcep0DLwwim9mKV0w6hyLKaPtyHQDiXlJBol64w"}
        .then((currentToken) => {
          if (currentToken) {
            localStorage.setItem('FCMToken', currentToken.toString());
            console.log(currentToken.toString())
          } else {
                // Show permission request UI
                console.log('No registration token available. Request permission to generate one.');
            }
          }).catch((err) => {
          console.log('An error occurred while retrieving token. ', err);
        });


        //To handle foreground messages
        onMessage(messaging, (message) => {
          this.notiCount()
          this.toastTitle = message.notification.title
          this.toastBody = message.notification.body
          this.snackbar = true

          
           
        })



      }else if( permission === "denied" ){
        alert('You denied sending notification for You !')
      }
    }

  } ,
  mounted() {

    if (localStorage.getItem("locale") == "en") {
      document.querySelector("body").classList.add("ltr");
    } else {
      document.querySelector("body").classList.remove("ltr");
    }



    if( localStorage.getItem('IsLoggedIn') == 'true' ){
      localStorage.setItem('IsLoggedIn', true)
    }else {
      localStorage.setItem('IsLoggedIn', false)
    }



  },
  created(){
    // this.token =  localStorage.getItem('token');
    // this.token = null;
    // this.user =  localStorage.getItem('user');
    // this.user = null
                this.requestPermission();
  },
  updated(){
  }

};
</script>


<style lang="scss">
$base-color: #1ec2a8;
$mainColor: #1ec2a8;
$mainColor2: #bdbaba;
// .notificationAlert{
//   position: fixed;
//   top:70px;
//   right:70px
// }
.notificationAlert a{
  color:#fff;
}
.notificationAlert .title{
  font-size: 18px;
  font-weight: 600;
}
.notificationAlert .body{
  font-size: 15px;
}
.mainColor {
  color: $mainColor;
}
.main_btn:disabled{
    opacity: .5;
    cursor: no-drop;
}
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
body {
  position: relative !important;
  direction: rtl !important;
  text-align: start !important;
  color: #212121 !important;
  font-family: "DIN-Arabic", sans-serif !important;
  background-color: #f7f7f7 !important;
}
@font-face {
  font-family: "DIN-Arabic-Bold";
  src: url("assets/fonts/URW-DIN-Arabic-Bold.ttf");
}
@font-face {
  font-family: "DIN-Arabic";
  src: url("assets/fonts/URW-DIN-Arabic.ttf");
}
@font-face {
  font-family: "Kalligraaf-Arabic-Medium";
  src: url("assets/fonts/Kalligraaf-Arabic-Medium.ttf");
}
.fontBold {
  font-weight: 600;
}
.v-locale--is-ltr {
  direction: rtl !important;
}
.labeledSection {
  position: relative;
  width: fit-content;
  &::before {
    content: "";
    position: absolute;
    width: 100%;
    height: 3px;
    background-color: #1ec2a8;
    left: 0;
    bottom: -7px;
  }
}
.button {
  background-color: #1ec2a8 !important;
  color: #fff;
  border-radius: 3px;
  padding: 8px 20px;
  text-decoration: none;
  margin-right: auto;
  margin-left: auto;
  &:hover {
    color: #fff !important;
  }
}
a {
  text-decoration: none !important;
  // color: ;
}

// inputs style
.form__label {
  position: relative;
  width: 100%;
  display: flex;
  align-items: center;
  margin-top: 10px;
  overflow: hidden;

  .default_input {
    position: relative;
    width: 100%;
    height: 45px;
    padding: 5px 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 15px;
    padding-inline-start: 40px;
  }

  .float__label {
    position: absolute;
    top: 13px;
    pointer-events: none;
    right: 40px;
    transition: 0.3s all cubic-bezier(0, 0.11, 0.4, 1.29);
    font-size: 13px;
    font-weight: 400;
    border-radius: 5px;
    z-index: 1;
    color: $mainColor2;
  }
  .icon-input {
    position: absolute;
    right: 1px;
    border: 1px solid #fff;
    top: 10px;
    font-size: 20px;
    color: rgb(100, 100, 100);
    background-color: #fff;
    z-index: 2;
    width: 40px;
    display: flex;
  }
  .flaot_icon {
    position: absolute;
    left: 0;
    width: 35px;
    height: 100%;
    bottom: 0;
  }
  .float_btn {
    position: absolute;
    left: 3px;
    top: 5px;
  }
}

.default_input:focus {
  & + .float__label {
    transform: translateX(150%);
  }
  // &+  .icon-input{
  //     color: $mainColor;
  // }
}

.default_input:not(:placeholder-shown) {
  & + .float__label {
    transform: translateX(150%);
  }
  // & +.icon-input{
  //     transform: translateX(150%);
  // }
}

textarea.default_input + .float__label {
  top: 18px;
  right: 17px;
}

.default_input:focus-visible {
  border-color: $mainColor;
}

textarea.default_input:focus + .float__label,
textarea.default_input:not(:placeholder-shown) + .float__label {
  transform: translateX(150%);
}

input:focus {
  outline: none;
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

.default_input::placeholder,
.input_footer input::placeholder {
  opacity: 0;
}

textarea.default_input {
  min-height: 150px;
  padding: 20px !important;
}

.default-link {
  color: $mainColor2;
}
.v-btn {
  color: #fff;
}

// font size
@for $i from 1 through 100 {
  .font#{$i} {
    font-size: $i + 2 + px !important;
  }
}
// flex gap
@for $i from 1 through 50 {
  .gap#{$i} {
    gap: $i + px !important;
  }
}

// button style

.fill:hover,
.fill:focus {
  box-shadow: inset 0 0 0 2em $mainColor;
  color: #fff;
}

.pulse:hover,
.pulse:focus {
  animation: pulse 1s;
  box-shadow: 0 0 0 2em rgba(#fff, 0);
}

@keyframes pulse {
  0% {
    box-shadow: 0 0 0 0 #fff;
  }
}

.close:hover,
.close:focus {
  box-shadow: inset -3.5em 0 0 0 $mainColor, inset 3.5em 0 0 0 $mainColor;
}

.raise:hover,
.raise:focus {
  box-shadow: 0 0.5em 0.5em -0.4em #fff;
  transform: translateY(-0.25em);
}

.up:hover,
.up:focus {
  box-shadow: inset 0 -4.25em 0 0 #fff;
  color: $mainColor !important;
  border: 1px solid $mainColor;
}

.slide:hover,
.slide:focus {
  box-shadow: inset 11.5em 0 0 0 #fff;
  color: $mainColor !important;
  border: 1px solid $mainColor;
}

.offset {
  box-shadow: 0.3em 0.3em 0 0 var(--color), inset 0.3em 0.3em 0 0 var(--color);

  &:hover,
  &:focus {
    box-shadow: 0 0 0 0 var(--mainOpacity),
      inset 6em 3.5em 0 0 var(--mainOpacity);
    color: #fff !important;
  }
}

.main_btn {
  border-radius: 5px;
  white-space: nowrap;
  color: #fff;
  padding: 5px 25px;
  min-width: 200px;
  height: 45px;
  width: fit-content;
  background-color: $mainColor;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: 0.3s all ease;

  &.fluid {
    background-color: #fff;
    color: $mainColor;
    border: 2px solid $mainColor;
  }

  &.radius {
    border-radius: 30px;
  }
}

.round_btn {
  background-color: $mainColor;
  border-radius: 40px;
  color: #fff;
  padding: 10px 20px;
  width: fit-content;
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 150px;

  &.fluid {
    background-color: #fff;
    border-radius: 40px;
    color: $mainColor;
    width: fit-content;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid $mainColor;

    &:hover {
      background-color: $mainColor;
      color: #fff;
    }
  }
}

.bg-main {
  background-color: $mainColor !important;
  color: #ffffff !important;
}
</style>

<style>
html {
  scroll-behavior: smooth;
}

::-webkit-scrollbar {
  width: 6px;
}

::-webkit-scrollbar-track {
  background: transparent;
}

::-webkit-scrollbar-thumb {
  border-radius: 25px;
  background-color: #2ABDC7;
}


@media( max-width:768px ){
  h5{
    font-size: 17px;
  }
  .v-dialog .v-overlay__content{
    width:90% !important;
  }
}
.alertCustom{
  font-family:"DIN-Arabic", sans-serif !important;;
}

/* transition  */
.slide-fade-enter-active {
  transition: all 0.3s ease-out;
}

.slide-fade-leave-active {
  transition: all 0.2s ease-in-out;
}

.slide-fade-enter-from,
.slide-fade-leave-to {
  transform: translateX(20px);
  opacity: .6;
}

#app{
  background-color: #fff;
}
</style>
