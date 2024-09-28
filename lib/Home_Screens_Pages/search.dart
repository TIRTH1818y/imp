import 'package:flutter/cupertino.dart';

class search_page extends StatefulWidget{
  const search_page({super.key});

  @override
  State<search_page> createState() => search_page_state();
}

class search_page_state extends State<search_page> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("search page"),);
  }
}