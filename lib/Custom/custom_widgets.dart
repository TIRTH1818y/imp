import 'package:flutter/material.dart';

class customscaffold extends StatelessWidget {
  const customscaffold({
    super.key,
    this.child,
    this.color,
    this.padding,
    this.conpadding,
  });

  final Widget? child;
  final color;
  final padding;
  final conpadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      // extendBodyBehindAppBar: true,
      body: Stack(children: [
        const Image(
          image: AssetImage("assets/images/h1jpg.jpg"),
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(
            child: Padding(
          padding: padding,
          child: AnimatedContainer(
              padding: conpadding,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              duration: const Duration(seconds: 2),
              child: child!),
        )),
      ]),
    );
  }
}
