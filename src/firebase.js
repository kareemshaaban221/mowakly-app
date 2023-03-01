// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getMessaging } from "firebase/messaging";

// import '../public/firebase-messaging-sw'

const firebaseConfig = {
  apiKey: "AIzaSyCVatag3g523DipmY3qBEHjPzUicEXstDA",
  authDomain: "fcmoffer.firebaseapp.com",
  projectId: "fcmoffer",
  storageBucket: "fcmoffer.appspot.com",
  messagingSenderId: "930156227310",
  appId: "1:930156227310:web:0b8243e6e75ace7d39a1ff",
  measurementId: "G-KTWPTP1T34"
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);
export const analytics = getAnalytics(app);
export const messaging = getMessaging(app);

// if ('serviceWorker' in navigator) {
//   window.addEventListener('load', () => {
//     navigator.serviceWorker.register('../public/firebase-messaging-sw');
//   });
// }
