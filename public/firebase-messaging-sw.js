
  importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
  importScripts(
    "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
  );

  
  const firebaseConfig = {
    apiKey: "AAAACCt-uuw:APA91bGRrYAXQ1DWg-yUvG284ltH-qXk0b3jHpH_btyELFcMcIJtgTu2L_l4XRDEpDihTyPtu012gGrWHiGrT20KIZVRCOoNkb37GXlfHME3_jvDf6vPWLyr4SenVhUYCbd0Jt1-q1Ho",
    // apiKey: "AIzaSyCVatag3g523DipmY3qBEHjPzUicEXstDA",
    authDomain: "fcmoffer.firebaseapp.com",
    projectId: "fcmoffer",
    storageBucket: "fcmoffer.appspot.com",
    messagingSenderId: "35089464044",
    // messagingSenderId: "930156227310",
    appId: "1:35089464044:web:0b8243e6e75ace7d39a1ff",
    measurementId: "G-KTWPTP1T34"

  };
      // eslint-disable-next-line
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();
  
  messaging.onBackgroundMessage((payload) => {
    console.log(
      "[firebase-messaging-sw.js] Received background message ",
      payload
    );
    
    
    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
      icon: payload.notification.image,
    };
  


    self.registration.showNotification(notificationTitle, notificationOptions);

});
  /* eslint-enable */