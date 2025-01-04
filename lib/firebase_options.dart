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
    apiKey: 'AIzaSyCiESePaQf7uYMPioyTIlbyB5B120RoHe0',
    appId: '1:606584437369:web:1554c8971f15f53643b2a8',
    messagingSenderId: '606584437369',
    projectId: 'e-commerce-2303',
    authDomain: 'e-commerce-2303.firebaseapp.com',
    storageBucket: 'e-commerce-2303.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiGZKgDH1xvRFlo7MwqKSPYOTVUHwtmGc',
    appId: '1:606584437369:android:6b56929f98cf5cec43b2a8',
    messagingSenderId: '606584437369',
    projectId: 'e-commerce-2303',
    storageBucket: 'e-commerce-2303.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIgcaf9MspwYK2nW8_9CjVYVCsNbtZa8M',
    appId: '1:606584437369:ios:164b6bd687924a9843b2a8',
    messagingSenderId: '606584437369',
    projectId: 'e-commerce-2303',
    storageBucket: 'e-commerce-2303.firebasestorage.app',
    iosBundleId: 'com.example.eCommerceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIgcaf9MspwYK2nW8_9CjVYVCsNbtZa8M',
    appId: '1:606584437369:ios:164b6bd687924a9843b2a8',
    messagingSenderId: '606584437369',
    projectId: 'e-commerce-2303',
    storageBucket: 'e-commerce-2303.firebasestorage.app',
    iosBundleId: 'com.example.eCommerceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCiESePaQf7uYMPioyTIlbyB5B120RoHe0',
    appId: '1:606584437369:web:d20f7d664f2606db43b2a8',
    messagingSenderId: '606584437369',
    projectId: 'e-commerce-2303',
    authDomain: 'e-commerce-2303.firebaseapp.com',
    storageBucket: 'e-commerce-2303.firebasestorage.app',
  );
}