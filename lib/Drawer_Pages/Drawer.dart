import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:itmaterialspoint/Drawer_Pages/Downloads.dart';
import '../Login_Register/Login.dart';
import '../Profile/profile.dart';
import '../Services/authentication.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, required this.colorBW});

  final bool colorBW;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var image;
  var name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> getImage() async {
    DocumentSnapshot snapshot = await usersCollection.doc(userId).get();
    if (snapshot.exists) {
      final Image = snapshot['image'];
      final Name = snapshot['name'];
      setState(() {
        image = Image;
        name = Name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: widget.colorBW ? Colors.white : Colors.grey.shade900,
      elevation: 10,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            curve: Curves.easeInOutCubicEmphasized,
            decoration: const BoxDecoration(
                // color: Colors.black54,
                image: DecorationImage(
                    image: AssetImage("assets/images/h1jpg.jpg"),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    colorFilter: ColorFilter.linearToSrgbGamma())),
            duration: const Duration(milliseconds: 200),
            child: CircleAvatar(
              radius: 25,
              child: ClipOval(
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  height: 134,
                  width: 134,
                  imageUrl: image.toString(),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person_2_outlined),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined,
                color: widget.colorBW ? Colors.black : Colors.white, size: 30),
            title: Text(
              'My Profile',
              style: TextStyle(
                color: widget.colorBW ? Colors.black : Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => profile(
                          colorBW: widget.colorBW,
                          callappbar: true,
                        )),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.download_for_offline_outlined,
                color: widget.colorBW ? Colors.black : Colors.white, size: 30),
            title: Text(
              'Downloads',
              style: TextStyle(
                color: widget.colorBW ? Colors.black : Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Downloads(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded,
                color: widget.colorBW ? Colors.redAccent : Colors.redAccent,
                size: 30),
            title: Text(
              'Log out',
              style: TextStyle(
                color: widget.colorBW ? Colors.black : Colors.white,
              ),
            ),
            onTap: () async {
              showAlert();
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outlined,
                color: widget.colorBW ? Colors.black : Colors.white, size: 30),
            title: Text(
              'About',
              style: TextStyle(
                color: widget.colorBW ? Colors.black : Colors.white,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  showAlert() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const ListTile(
            title: Text(
              "Are You Sure Logout?",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () async {
                    await GoogleSignIn().signOut();
                    await AuthServices().signOut();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
              const SizedBox(
                width: 60,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
            ],
          ),
        );
      },
    );
  }
}
