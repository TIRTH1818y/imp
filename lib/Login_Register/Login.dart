import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:itmaterialspoint/UI_widgets/elevated.dart';
import '../Custom/custom_widgets.dart';
import '../Custom/theme.dart';
import '../Home_Screens_Pages/Home.dart';
import '../Services/authentication.dart';
import '../Services/mail_verification.dart';
import '../UI_widgets/snack_bar.dart';
import 'Register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<LoginScreen> {
  final _forsigninkey = GlobalKey<FormState>();
  bool rememberpassword = true;
  bool isLoading = false;
  bool isHide = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser() async {
    String res = await AuthServices().loginUser(
      email: emailController.text.toString().trim(),
      password: passwordController.text.toString().trim(),
    );

    if (res == "success") {
      setState(() {
        isLoading = true;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const verifyEmail(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
        return null;
      });
      // Access Google user data from googleUserC object
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return customscaffold(
      conpadding: const EdgeInsets.only(right: 25, left: 25),
      color: Colors.white70,
      padding: const EdgeInsets.only(top: 220.0),
      child: Column(
        children: [

          Expanded(
              flex: 7,
              child: Form(
                key: _forsigninkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Welcome Back",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: lightColorScheme.primary,
                          )),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 50,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please Enter Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          label: const Text('Email'),
                          hintText: 'Enter Email',
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isHide,
                        obscuringCharacter: '●',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please Enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(isHide
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_sharp),
                            onPressed: () {
                              setState(() {
                                isHide = !isHide;
                              });
                            },
                          ),
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          label: const Text('Password'),
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberpassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberpassword = value!;
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                              const Text(
                                'Remember Me',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElvB(
                          onTab: () {
                            if (_forsigninkey.currentState!.validate() &&
                                rememberpassword) {
                              setState(() {
                                isLoading = true;
                              });
                              loginUser();
                            } else if (!rememberpassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please agree to the processing of personal data'),
                                ),
                              );
                            }
                          },
                          text: 'Login',
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Divider(
                            thickness: 2,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: Text(
                              'Or Login With',
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          SizedBox(height: 25),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              signInWithGoogle();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              animationDuration: const Duration(seconds: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.white70,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/google.png"),
                                    height: 40,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t Have a Account?',
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
