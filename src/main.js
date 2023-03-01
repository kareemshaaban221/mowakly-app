import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify'
import { loadFonts } from './plugins/webfontloader'
import Vuelidate from 'vuelidate';
import './firebase'

import Toaster from '@meforma/vue-toaster';

import infiniteScroll from 'vue-infinite-scroll'
import Dropdown from 'vue-simple-search-dropdown';

import VueObserveVisibility from 'vue-observe-visibility'





// import '../public/firebase-messaging-sw'



loadFonts();


// import bootstrap 
import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'normalize.css'


// import fontawesome 
import { library, dom } from "@fortawesome/fontawesome-svg-core";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { fas } from '@fortawesome/free-solid-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons';
import { far } from '@fortawesome/free-regular-svg-icons';
library.add(fas, far, fab)
dom.watch();


// import axios 
import axios from 'axios';
axios.defaults.baseURL = 'https://offbx.com/api/'
axios.defaults.headers.common['Authorization'] =  `Bearer ${localStorage.getItem('token')}`;
axios.defaults.headers.lang = localStorage.getItem('locale');


// import i18n 
import VueI18n from 'vue-i18n'
import i18n from './i18n'


// import sweetalert 
import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';


// import pagination
import Paginate from "vuejs-paginate-next";

import { createHead } from "unhead"
// Create a global head instance
const head = createHead()


createApp(App)
  .use(router)
  .use(VueSweetalert2)
  .use(store)
  .use(vuetify)
  .use(Vuelidate)
  .use(i18n).use(VueI18n)
  .use(head)  
  .use(Toaster)
  .use(infiniteScroll)
  .use(Dropdown)
  .use(VueObserveVisibility)
  .component("font-awesome-icon", FontAwesomeIcon)
  .use(Paginate)
  .mount('#app')