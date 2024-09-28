import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:itmaterialspoint/Drawer_Pages/Drawer.dart';
import 'package:itmaterialspoint/Home_Screens_Pages/search.dart';
import 'package:itmaterialspoint/Home_Screens_Pages/technology_page.dart';
import 'package:itmaterialspoint/Profile/profile.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Profile/edit_profile.dart';
import 'home_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _homeState();
}

class _homeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  setGoogleUser();
    requestStoragePermission();
  }

  bool colorBW = false;

  // setGoogleUser() async {
  //   if (FirebaseAuth.instance.currentUser!.providerData
  //       .any((provider) => provider.providerId == "google.com")) {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleUser =
  //     await googleSignIn.signInSilently();
  //     if (googleUser != null) {
  //       final userId = FirebaseAuth.instance.currentUser!.uid;
  //       final name = googleUser.displayName;
  //       final email = googleUser.email;
  //       final photoUrl = googleUser.photoUrl.toString();
  //       DocumentSnapshot User = await FirebaseFirestore.instance
  //           .collection("Users")
  //           .doc(userId)
  //           .get();
  //       if (User.exists) {
  //         print("This Google User Is Already Exist.");
  //       } else {
  //         FirebaseFirestore.instance.collection("Users").doc(userId).set({
  //           "name": name.toString(),
  //           "email": email.toString(),
  //           'uid': userId.toString(),
  //           "birthdate": "",
  //           "image": photoUrl,
  //           "phone": "",
  //           "bio": "",
  //           "password" : ""
  //         });
  //
  //         print(" Google User Set Successfully");
  //       }
  //     }
  //   } else {
  //     print("Email User Found! ");
  //   }
  // }

  Future<bool> requestStoragePermission() async {
    // Check current permission status
    await Permission.storage.request();
    // If permission not granted, request it
    if (await Permission.storage.isGranted) {
      print("Storage Permission Granted.");
    } else if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    } else if (await Permission.storage.isPermanentlyDenied) {
      return Permission.storage.isGranted;
    }

    // Return true if permission granted, false otherwise
    return Permission.storage.isGranted;
  }

  final GlobalKey<ScaffoldState> _scafoldkey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const home_page(),
      const search_page(),
      techno_page(
        colorBW: colorBW,
      ),
      profile(
        colorBW: colorBW,
        callappbar: false,
      ),
    ];
    return Scaffold(
      backgroundColor: !colorBW ? Colors.grey[800] : Colors.white,
      key: _scafoldkey,
      drawer: MyDrawer(
        colorBW: colorBW,
      ),
      bottomNavigationBar: GNav(
        curve: Curves.easeInOut,
        style: GnavStyle.google,
        gap: 5,
        tabMargin: const EdgeInsets.only(top: 7, bottom: 7),
        activeColor: colorBW ? Colors.white : Colors.cyanAccent,
        color: colorBW ? Colors.black : Colors.white70,
        iconSize: 20,
        backgroundColor: colorBW ? Colors.black26 : Colors.black,
        padding: const EdgeInsets.all(18),
        duration: const Duration(milliseconds: 200),
        tabBackgroundColor: colorBW ? Colors.black54 : Colors.black,
        rippleColor: colorBW ? Colors.white : Colors.cyan,
        onTabChange: (index) {
          if (mounted == true) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        tabs: [
          GButton(
            icon: Icons.home,
            iconSize: 20,
            text: 'Home',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.language,
            text: 'Technologies',
          ),
          GButton(
            icon: Icons.account_circle_outlined,
            text: 'Profile',
          ),
        ],
        selectedIndex: _selectedIndex,
      ),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: !colorBW ? Colors.black : Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.menu_sharp,
              color: colorBW ? Colors.black : Colors.white),
          onPressed: () {
            _scafoldkey.currentState!.openDrawer();
          },
          style: const ButtonStyle(
              animationDuration: Duration(milliseconds: 2000)),
        ),
        // backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "IT ",
              style: TextStyle(
                  fontFamily: "karsyu",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: !colorBW ? Colors.white70 : Colors.black45),
            ),
            Text(
              "Material ",
              style: TextStyle(
                  fontFamily: "karsyu",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.blueGrey),
            ),
            Text(
              "Point",
              style: TextStyle(
                  fontFamily: "karsyu",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.tealAccent),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  colorBW = !colorBW;
                });
              },
              icon: Icon(
                !colorBW ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              ),
              color: !colorBW ? Colors.white : Colors.black),
          _selectedIndex == 3
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.edit_rounded),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile(
                                    colorBW: colorBW,
                                  )));
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
      //for displaying Items
      body: Container(
        child: widgetOptions[_selectedIndex],
      ),
    );
  }
}
