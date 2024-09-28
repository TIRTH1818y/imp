import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itmaterialspoint/Login_Register/Login.dart';
import 'package:itmaterialspoint/UI_widgets/elevated.dart';
import 'package:itmaterialspoint/UI_widgets/snack_bar.dart';

import '../Home_Screens_Pages/Home.dart';

class verifyEmail extends StatefulWidget {
  const verifyEmail({super.key});

  @override
  State<verifyEmail> createState() => _verifyEmailState();
}

class _verifyEmailState extends State<verifyEmail> {

  Timer? timer;
  bool canResendEmail = true;
  bool isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 2), (_) => checkEmailVerified());
    if (!isEmailVerified) {
      sendVerificationEmail();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const Home()
      : Scaffold(
          appBar: AppBar(
            elevation: 5,
            title: const Text("Verifying  Email.."),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "A Verification Mail  Is Sent to Your Email.",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: canResendEmail
                      ? ElvB(
                          onTab: () {
                            canResendEmail == true
                                ? FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                : null;
                            if(!canResendEmail) isLoading = false;
                            if (isEmailVerified) Navigator.pop(context);
                          },
                          text: "Resend Email",

                        )
                      : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 10,),
                          Text(
                              "Verifying Email..",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                        ],
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElvB(
                      onTab: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                        showSnackBar(context,
                            "You Have Been Signed Up But You Must Verify Your Account.");
                      },
                      text: "Cancel"),
                )
              ],
            ),
          ),
        );
}
