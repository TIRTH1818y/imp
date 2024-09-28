import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itmaterialspoint/Custom/welcome.dart';

import '../Home_Screens_Pages/Home.dart';
import '../Services/mail_verification.dart';

class splash_screen extends StatefulWidget {
  final snapShot;

  const splash_screen({super.key, required this.snapShot});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    timer();
  }

  void timer() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (widget.snapShot.hasData) {
              if (FirebaseAuth.instance.currentUser!.providerData
                  .any((provider) => provider.providerId == "google.com")) {
                return const Home();
              } else {
                return const verifyEmail();
              }
            } else {
              return const welcome();
            }
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset("assets/images/Splash.gif",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
        ],
      ),
    );
  }
}
