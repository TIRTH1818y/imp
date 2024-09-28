import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:itmaterialspoint/Custom/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyA9vOyJCxtbIz9n9iDfnHUmccnmxNOHMvU',
              appId: '1:373637410895:android:2f21cc5d1a416c4ff8ba3a',
              messagingSenderId: '373637410895',
              projectId: 'it-materials-point'))
      : await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

  runApp(const MyApp());
}

// FirebaseAuth auth = FirebaseAuth.instance;
// FirebaseFirestore firestore = FirebaseFirestore.instance;
//
// Stream<User?> userStream = auth.authStateChanges();
//
// userStream.listen((User? user) async {
// if (user != null) {
// // Check if password reset was successful (e.g., by comparing email or UID)
//
// DocumentSnapshot userDoc = await firestore.collection('users').doc(user.uid).get();
//
// // Update password field with the new password (ensure it's securely hashed)
// await userDoc.reference.update({'password': hashedNewPassword});
// }
// });

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            return splash_screen(snapShot: snapShot,);
          }),
    );
  }
}
