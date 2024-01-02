// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
    apiKey: 'AIzaSyCgr2OZ5-qZK6uAd3EJRMaLnvAE2eIz82g',
    appId: '1:620469384350:web:81387c101d4900b023b78f',
    messagingSenderId: '620469384350',
    projectId: 'findingclothes-3b19b',
    authDomain: 'findingclothes-3b19b.firebaseapp.com',
    storageBucket: 'findingclothes-3b19b.appspot.com',
    measurementId: 'G-DZJ2G3GYR9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCFOFnmeHO1ZH008tFbYvQJAyd3VJT6AQ',
    appId: '1:620469384350:android:d96e01bfbce806f223b78f',
    messagingSenderId: '620469384350',
    projectId: 'findingclothes-3b19b',
    storageBucket: 'findingclothes-3b19b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5UbRkz0QxsLJL9XazoKy_IOvQUm_JbDE',
    appId: '1:620469384350:ios:608458c90544da8423b78f',
    messagingSenderId: '620469384350',
    projectId: 'findingclothes-3b19b',
    storageBucket: 'findingclothes-3b19b.appspot.com',
    iosClientId: '620469384350-512h11n0s7c11u5fvffkpdadhnpub2f8.apps.googleusercontent.com',
    iosBundleId: 'com.example.findingClothes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5UbRkz0QxsLJL9XazoKy_IOvQUm_JbDE',
    appId: '1:620469384350:ios:f174317eb2f667c123b78f',
    messagingSenderId: '620469384350',
    projectId: 'findingclothes-3b19b',
    storageBucket: 'findingclothes-3b19b.appspot.com',
    iosClientId: '620469384350-867qjmmk0c3k4o597j20s8okv68uik3m.apps.googleusercontent.com',
    iosBundleId: 'com.example.findingClothes.RunnerTests',
  );
}
