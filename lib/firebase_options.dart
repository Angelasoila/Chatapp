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
        return windows;
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
    apiKey: 'AIzaSyCcKNmPEViMObj8-zJUkBlXihbBSHdaLVc',
    appId: '1:644873254628:web:f73f7da15bdc8e608c1ef1',
    messagingSenderId: '644873254628',
    projectId: 'flutter-dd34b',
    authDomain: 'flutter-dd34b.firebaseapp.com',
    storageBucket: 'flutter-dd34b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1Q7DOmV1MRqNGJ6ykoKplNkTTxTmVVsc',
    appId: '1:836436130603:ios:b5876917419f25ba5b636e',
    messagingSenderId: '836436130603',
    projectId: 'chatapp-9b1d0',
    storageBucket: 'chatapp-9b1d0.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1Q7DOmV1MRqNGJ6ykoKplNkTTxTmVVsc',
    appId: '1:836436130603:ios:b5876917419f25ba5b636e',
    messagingSenderId: '836436130603',
    projectId: 'chatapp-9b1d0',
    storageBucket: 'chatapp-9b1d0.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication4',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCcKNmPEViMObj8-zJUkBlXihbBSHdaLVc',
    appId: '1:644873254628:web:65c051e54e57eff38c1ef1',
    messagingSenderId: '644873254628',
    projectId: 'flutter-dd34b',
    authDomain: 'flutter-dd34b.firebaseapp.com',
    storageBucket: 'flutter-dd34b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMNuYHJAptT5_Y0GuvMYIV6aw-E8ZMGWQ',
    appId: '1:644873254628:android:280d7ebb1c3864418c1ef1',
    messagingSenderId: '644873254628',
    projectId: 'flutter-dd34b',
    storageBucket: 'flutter-dd34b.firebasestorage.app',
  );

}