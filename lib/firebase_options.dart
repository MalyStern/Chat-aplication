import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDN_RPLGENd291rDcD5dHsf080YeP09U_4',
    appId: '1:333018249688:android:6ef8cbab1c31f991ba5aad',
    projectId: 'chat-b7775',
    messagingSenderId: '333018249688',
    storageBucket: 'chat-b7775.appspot.com',
  );
}
