import 'package:flutter/material.dart';

class ElvB extends StatelessWidget {
  const ElvB({super.key, required this.onTab, required this.text, this.child});

  final VoidCallback onTab;
  final String text;
  final child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 50,
      child: ElevatedButton(
        onPressed: onTab,
        style: ElevatedButton.styleFrom(
            animationDuration: const Duration(seconds: 2),
            elevation: 10,
            shape: const StadiumBorder(
              side: BorderSide(
                  width: 2, style: BorderStyle.solid, color: Colors.white12),
            ),
            backgroundColor: Colors.blue,
            shadowColor: Colors.blue,
            iconColor: Colors.black),
        child:  Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: child,
              ),
            ),
          ],
        ),


        //       child: Text(
      ),
    );
  }
}
