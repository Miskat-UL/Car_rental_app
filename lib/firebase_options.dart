
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDqEs0LVtEiL7Fau8WIDqa0GQc4OW_l3Ko',
    appId: '1:935634388153:web:4ec9c39f9375143da5c768',
    messagingSenderId: '935634388153',
    projectId: 'flutter-firebase-23',
    authDomain: 'flutter-firebase-23.firebaseapp.com',
    storageBucket: 'flutter-firebase-23.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXViWDcoVCtgiDZ8AqthS1kTIyxTnb75w',
    appId: '1:935634388153:android:0627d7f73e7aa399a5c768',
    messagingSenderId: '935634388153',
    projectId: 'flutter-firebase-23',
    storageBucket: 'flutter-firebase-23.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBHYPor6HY1AEROar9pTNs2VUC2dnipZ4',
    appId: '1:935634388153:ios:9e30481d3d0ca5c1a5c768',
    messagingSenderId: '935634388153',
    projectId: 'flutter-firebase-23',
    storageBucket: 'flutter-firebase-23.appspot.com',
    iosClientId: '935634388153-an70f9cv4li6bs9cecet2u85ibm3c0eq.apps.googleusercontent.com',
    iosBundleId: 'com.example.carRentalApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBHYPor6HY1AEROar9pTNs2VUC2dnipZ4',
    appId: '1:935634388153:ios:9e30481d3d0ca5c1a5c768',
    messagingSenderId: '935634388153',
    projectId: 'flutter-firebase-23',
    storageBucket: 'flutter-firebase-23.appspot.com',
    iosClientId: '935634388153-an70f9cv4li6bs9cecet2u85ibm3c0eq.apps.googleusercontent.com',
    iosBundleId: 'com.example.carRentalApp',
  );
}
