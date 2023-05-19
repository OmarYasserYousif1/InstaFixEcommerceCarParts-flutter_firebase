import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get paltformOptions {
    if (Platform.isIOS) {
      return const FirebaseOptions(
          apiKey: "hkgjhgjhk",
          appId: "jhjfjfj",
          messagingSenderId: "01025050621",
          projectId: "ggjhjkjg",
          iosBundleId: "jjhgjhfhjgf");
    } else {
      return const FirebaseOptions(
          apiKey: "AIzaSyAQ3qnMWvD4JXkmjUZMAuQbWeBPOCnC-NU",
          appId: "1:1019504455766:android:aefd7efa3922fbe1404bf7",
          messagingSenderId: "1019504455766",
          projectId: "instafix-mobile-app");
    }
  }
}
