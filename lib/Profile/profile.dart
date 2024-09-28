import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itmaterialspoint/Profile/edit_profile.dart';

class profile extends StatefulWidget {
  const profile({super.key, required this.callappbar, required this.colorBW});

  final bool colorBW;
  final callappbar;

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.callappbar == true
          ? AppBar(
              title: const Text("Profile",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
              elevation: 2,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.edit_rounded),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile(
                                    colorBW: widget.colorBW,
                                  )));
                    },
                  ),
                ),
              ],
            )
          : null,
      body: StreamBuilder<DocumentSnapshot>(
        stream: usersCollection.doc(userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final name = userData['name'].toString();
          final email = userData['email'].toString();
          final phone = userData['phone'].toString();
          var birthdate = userData['birthdate'].toString();
          var bio = userData['bio'].toString();
          var image = userData['image'].toString();

          if (birthdate == "" && bio == "") {
            birthdate = "Add BirthDate";
            bio = "Add  Bio";
          }

          return Container(
            color: widget.colorBW ? Colors.white : Colors.grey[800],
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade600,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: CircleAvatar(
                            radius: 70,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                                imageUrl: image,
                                placeholder: (context, url) =>
                                    const Center(
                                        child:
                                            CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.person_2_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        name,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 350),
                  child: Text(
                    "Info",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: widget.colorBW ? Colors.white : Colors.grey[700],
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      title: const Text(
                        "Email",
                        style: TextStyle(fontSize: 20, color: Colors.cyan),
                      ),
                      subtitle: Text(
                        email,
                        style:  const TextStyle(
                            fontSize: 20, color:Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: widget.colorBW ? Colors.white : Colors.grey[700],
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      title: const Text(
                        "Mobile Number",
                        style: TextStyle(fontSize: 20, color: Colors.cyan),
                      ),
                      subtitle: Text(
                        phone,
                        style: const TextStyle(
                            fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: widget.colorBW ? Colors.white : Colors.grey[700],
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      title: const Text(
                        "BirthDate",
                        style: TextStyle(fontSize: 20, color: Colors.cyan),
                      ),
                      subtitle: Text(
                        birthdate,
                        style: const TextStyle(
                            fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: widget.colorBW ? Colors.white : Colors.grey[700],
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      title: const Text(
                        "Bio",
                        style: TextStyle(fontSize: 20, color: Colors.cyan),
                      ),
                      subtitle: Text(
                        bio,
                        style: const TextStyle(
                            fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
