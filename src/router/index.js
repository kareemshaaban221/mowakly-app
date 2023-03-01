import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue';
import siteStores from '../views/SiteStores.vue';
import siteOffers from '../views/SiteOffers.vue';
import siteFavs from '../views/siteFavourites.vue';
import singleStore from '../views/singleStore.vue';
import UserProfile from '../views/UserProofile.vue'
import HomeLogin from '../views/HomeLogin.vue';
import forgetPassowrd from '../views/forgetPassowrd.vue';
import AboutUs from '../views/AboutUs.vue';
import ContactUs from '../views/contactUs.vue'
import confirmCode from '../views/confirmCode.vue';
import confirmPassword from '../views/confirmPassword.vue';
import HomeRegester from '../views/HomeRegester.vue';
import OfferDescription from '../views/OfferDescription.vue';
import NotificationPage from '../views/NotificationPage.vue';

import fileredcates from '../views/filteredCategories.vue'
import storeCats from '../views/storeCates.vue'
import activeAcount from '../views/regActivateAcountCode.vue'

// import store from '../store/index'



const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/HomeLogin',
    name: 'HomeLogin',
    component: HomeLogin
  },
  {
    path: '/HomeRegester',
    name: 'HomeRegester',
    component: HomeRegester
  },
  {
    path: '/forgetPassowrd',
    name: 'forgetPassowrd',
    component: forgetPassowrd
  },
  {
    path : '/stores',
    name : 'stores',
    component : siteStores,
  },
  {
    path : '/NotificationPage',
    name : 'NotificationPage',
    component : NotificationPage,
    meta : { requiresAuth : true }
  },
  {
    path : '/confirmCode',
    name : 'confirmCode',
    component : confirmCode
  },
  {
    path : '/confirmPassword',
    name : 'confirmPassword',
    component : confirmPassword
  },
  {
    path: '/offers',
    name : 'offers',
    component : siteOffers
  },
  {
    path : '/favorites',
    name : 'favorites',
    component : siteFavs,
    meta : { requiresAuth : true }
  },
  {
    path: '/store/:id',
    name : 'store',
    component : singleStore
  },
  {
    path:'/fileredcategories/:id',
    name : 'fileredcates',
    component : fileredcates
  },
  {
    path:'/storeCategories/:id',
    name : 'storeCategories',
    component  : storeCats
    
  },
  {
    path : '/profile',
    name : 'profile',
    component : UserProfile,
    meta : { requiresAuth : true }
  },
  {
    path : '/about-us',
    name : 'about-us',
    component :AboutUs
  },
  {
    path : '/ContactUs',
    name : 'ContactUs',
    component : ContactUs
  },{

    path: '/OfferDescription/:id',
    name : 'OfferDescription',
    component : OfferDescription
  },
  {
    path : '/activeAcount',
    name : 'activeAcount',
    component : activeAcount
  }

]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
  scrollBehavior(){
    scrollTo(0, 0)
  }
})



router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (localStorage.getItem('IsLoggedIn') === 'false') {
      next({ name: 'HomeLogin' })
    } else {
      next() // go to wherever I'm going
    }
  } else {
    next() // does not require auth, make sure to always call next()!
  }
})

export default router
