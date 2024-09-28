import 'package:flutter/material.dart';
import 'package:itmaterialspoint/Custom/theme.dart';
import 'package:itmaterialspoint/Login_Register/Login.dart';
import '../Login_Register/Register.dart';
import 'custom_button.dart';
import 'custom_widgets.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return customscaffold(
      color: Colors.transparent,
      padding: const EdgeInsets.only(),
      conpadding: const EdgeInsets.only(),
      child: Column(
        children: [
          const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black26,
              child: Image(
                image: AssetImage("assets/images/logo.png"),
                height: 100,
                width: 100,
              )),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 50,
            ),
            child: const Center(
                child: Column(
              children: [
                Text(
                  "Welcome To",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 50,
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "IT ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey),
                    ),
                    Text(
                      "Material ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Text(
                      "Point",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.tealAccent),
                    ),
                  ],
                ),
              ],
            )),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Expanded(
                      child: welcomebutton(
                    buttonText: 'Login',
                    ontap: LoginScreen(),
                    color: Colors.white24,
                    textColor: Colors.white,
                    topright: 100.0,
                    topleft: 100.0,
                        bottomleft: 100.0,
                        bottomright: 100.0,
                  )),
                  Expanded(
                      child: welcomebutton(
                    buttonText: 'Register',
                    ontap: const RegisterScreen(),
                    color: Colors.white,
                    textColor: lightColorScheme.primary,
                    topleft: 100.0,
                    topright: 100.0,
                        bottomleft: 100.0,
                        bottomright: 100.0,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
