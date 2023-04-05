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
    apiKey: 'AIzaSyAeQP15IK_7dHJEtEoEozj1WlZi1g0dmAo',
    appId: '1:1062099426284:android:e3966354f446102d423ec9',
    messagingSenderId: '1062099426284',
    projectId: 'helping-hand-92c43',
    databaseURL: 'https://helping-hand-92c43-default-rtdb.firebaseio.com',
    storageBucket: 'helping-hand-92c43.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjD1lUax8hbNqEaqbJKwpzDVrdr5-bj_Q',
    appId: '1:1062099426284:ios:48a94ce615ecd68c423ec9',
    messagingSenderId: '1062099426284',
    projectId: 'helping-hand-92c43',
    databaseURL: 'https://helping-hand-92c43-default-rtdb.firebaseio.com',
    storageBucket: 'helping-hand-92c43.appspot.com',
    iosClientId: '1062099426284-9pve4nashh63ppojtrrccnaujm7ammpt.apps.googleusercontent.com',
    iosBundleId: 'com.example.helpingHand',
  );
}
