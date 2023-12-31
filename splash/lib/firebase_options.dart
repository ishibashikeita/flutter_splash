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
    apiKey: 'AIzaSyDgLunu1lRidUhoHvzoD_v4WVBHKNanN60',
    appId: '1:49398205380:web:b994ab9c5a58840ac9b291',
    messagingSenderId: '49398205380',
    projectId: 'splash-d79e2',
    authDomain: 'splash-d79e2.firebaseapp.com',
    storageBucket: 'splash-d79e2.appspot.com',
    measurementId: 'G-JS5Q6TV92C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKmmWn8vdkCgFLuMrw0a7F3gmAaB2LqOo',
    appId: '1:49398205380:android:2541b8a97476fdc3c9b291',
    messagingSenderId: '49398205380',
    projectId: 'splash-d79e2',
    storageBucket: 'splash-d79e2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBL9jUvm5MGMRdjh0kIu8a9oHCVTeu1a3Y',
    appId: '1:49398205380:ios:7460af09224538cdc9b291',
    messagingSenderId: '49398205380',
    projectId: 'splash-d79e2',
    storageBucket: 'splash-d79e2.appspot.com',
    iosBundleId: 'com.example.splash1102',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBL9jUvm5MGMRdjh0kIu8a9oHCVTeu1a3Y',
    appId: '1:49398205380:ios:21b16c43f3ad1c98c9b291',
    messagingSenderId: '49398205380',
    projectId: 'splash-d79e2',
    storageBucket: 'splash-d79e2.appspot.com',
    iosBundleId: 'com.example.splash.RunnerTests',
  );
}
