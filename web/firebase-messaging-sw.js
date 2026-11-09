importScripts('https://www.gstatic.com/firebasejs/10.13.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.13.2/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyADSX6q9hT6DE9ncy3Sug6UZKFZg14ZrdI",
  authDomain: "indrajaya-bb9d3.firebaseapp.com",
  projectId: "indrajaya-bb9d3",
  storageBucket: "indrajaya-bb9d3.firebasestorage.app",
  messagingSenderId: "269928620557",
  appId: "1:269928620557:web:582743010ba947d542ab44"
});

const messaging = firebase.messaging();
messaging.onBackgroundMessage((payload) => {
  console.log('[BACKGROUND] Notification received');

  const notificationTitle =
    payload.notification?.title || 'Notifikasi';

  const notificationOptions = {
    body: payload.notification?.body || '',
    icon: '/icons/Icon-192.png',
  };

  self.registration.showNotification(
    notificationTitle,
    notificationOptions
  );
});