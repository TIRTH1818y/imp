import 'package:flutter/material.dart';

class welcomebutton extends StatelessWidget {

  final String? buttonText;
  final Widget? ontap;
  final Color? color;
  final Color? textColor;
  final  topleft;
  final  topright;
  final bottomleft;
  final bottomright;
  const welcomebutton({super.key, this.buttonText,this.ontap,this.color,this.textColor,  this.topleft,  this.topright, this.bottomleft, this.bottomright});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ontap!,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(30),
            decoration:  BoxDecoration(
                color: color!,
                borderRadius:  BorderRadius.only(topLeft: Radius.circular(topleft),topRight: Radius.circular(topright),bottomLeft:Radius.circular(bottomleft),bottomRight: Radius.circular(bottomright) )),
            child: Text(
              buttonText!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor!,
              ),
            )),
      ),
    );
  }
}
