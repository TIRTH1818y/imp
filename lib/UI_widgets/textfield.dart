import 'package:flutter/material.dart';

class TxtF extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData prefixIcon;
  final keyboard;
  final length;
  final enable;
  final keys;
  final suffixIcon;

  const TxtF({super.key, 
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.prefixIcon,
    this.keyboard,
    this.length,
    this.keys,
    this.enable,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        key: keys,
        maxLength: length,
        keyboardType: keyboard,
        obscureText: isPass,
        controller: textEditingController,
        enabled: enable,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          hintText: hintText,
          prefixIcon: Icon(prefixIcon, color: Colors.black45),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.blue.shade100,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.blue),
              borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
