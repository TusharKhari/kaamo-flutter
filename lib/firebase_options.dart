// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4c-3KCXbDUxRSdGrohiJs1tzlRBf46a8',
    appId: '1:1029362855198:android:92ca152bc392f082a62d0f',
    messagingSenderId: '1029362855198',
    projectId: 'kamo-7b1be',
    databaseURL:
        'https://kamo-7b1be-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kamo-7b1be.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCynRle0fo64rikdCdqQPBQgFSZCmf_Wok',
    appId: '1:1029362855198:ios:200291d268a44595a62d0f',
    messagingSenderId: '1029362855198',
    projectId: 'kamo-7b1be',
    databaseURL:
        'https://kamo-7b1be-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'kamo-7b1be.firebasestorage.app',
    androidClientId:
        '1029362855198-fsr0s05q2gcql7orgskb2523lo3fh7e3.apps.googleusercontent.com',
    iosClientId:
        '1029362855198-2k7ctqfcpshtgrp0f086uh08jmrmg4fs.apps.googleusercontent.com',
    iosBundleId: 'com.example.kamo',
  );
}
