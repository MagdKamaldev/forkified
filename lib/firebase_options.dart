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
    apiKey: 'AIzaSyBK-uztpUWirGZTlq4G8VOk_XcXO4q2H3M',
    appId: '1:597652956650:web:98e6530c5512212dcdbe93',
    messagingSenderId: '597652956650',
    projectId: 'forkified-74f3a',
    authDomain: 'forkified-74f3a.firebaseapp.com',
    storageBucket: 'forkified-74f3a.appspot.com',
    measurementId: 'G-W6ZLR9VHR0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUxnoAQYaWzLQaS1Rhg_KMHw8yWExnSCY',
    appId: '1:597652956650:android:14efdc4a211882d7cdbe93',
    messagingSenderId: '597652956650',
    projectId: 'forkified-74f3a',
    storageBucket: 'forkified-74f3a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQ-EfhQSfFlnEdEriZdtfO4CNW21vtcm0',
    appId: '1:597652956650:ios:395c4724494e6faecdbe93',
    messagingSenderId: '597652956650',
    projectId: 'forkified-74f3a',
    storageBucket: 'forkified-74f3a.appspot.com',
    iosBundleId: 'com.example.forkified',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQ-EfhQSfFlnEdEriZdtfO4CNW21vtcm0',
    appId: '1:597652956650:ios:6313647848faf3cdcdbe93',
    messagingSenderId: '597652956650',
    projectId: 'forkified-74f3a',
    storageBucket: 'forkified-74f3a.appspot.com',
    iosBundleId: 'com.example.forkified.RunnerTests',
  );
}
