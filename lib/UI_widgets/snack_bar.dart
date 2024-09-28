import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      elevation: 5,
      duration: const Duration(seconds: 2),
    ),
  );
}
