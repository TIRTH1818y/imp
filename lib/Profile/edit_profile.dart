import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itmaterialspoint/UI_widgets/elevated.dart';
import 'package:itmaterialspoint/UI_widgets/snack_bar.dart';
import 'package:itmaterialspoint/UI_widgets/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditProfile extends StatefulWidget {
  final bool colorBW;

  const EditProfile({
    super.key,
    required this.colorBW,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;

  final DOBcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final BIOcontroller = TextEditingController();

  File? pickedImage;
  final _imagePicker = ImagePicker();

  String userId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> update() async {
      try {
        if (pickedImage != null) {
          UploadTask uploadTask = FirebaseStorage.instance
              .ref("UserImages")
              .child(userId)
              .putFile(pickedImage!);

          TaskSnapshot taskSnapshot = await uploadTask;
          String imageURL = await taskSnapshot.ref.getDownloadURL();
          await userCollection.doc(userId).update({'image': imageURL});
        }
        String dob = DOBcontroller.text;
        String bio = BIOcontroller.text;
        String name = namecontroller.text;
        await userCollection.doc(userId).update({
          'name': name,
          'birthdate': dob,
          'bio': bio,
        });
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }

    showAlertBox() {
      return showDialog(
        barrierColor: Colors.black45,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
            title: const Text(
              "Select Image",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () async {
                    try {
                      final photo = await _imagePicker.pickImage(
                          source: ImageSource.camera);
                      if (photo != null) {
                        final tempImage = File(photo.path);
                        setState(() {
                          pickedImage = tempImage;
                        });
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.camera,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Camera",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    try {
                      final photo = await _imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (photo != null) {
                        final tempImage = File(photo.path);
                        setState(() {
                          pickedImage = tempImage;
                        });
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.image, color: Colors.black),
                  title: const Text("Gallary",
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          );
        },
      );
    }

    return StreamBuilder(
      stream: userCollection.doc(userId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          showSnackBar(context, snapshot.hasError.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final image = userData['image'].toString();
        var name = userData['name'];
        var birthdate = userData['birthdate'];
        var bio = userData['bio'];
        // if(bio == ""){
        //     bio = "Please Enter Bio";
        // }
        // if(birthdate == ""){
        //     birthdate = "Please Enter BirthDate";
        // }

        DOBcontroller.text = birthdate.toString();
        BIOcontroller.text = bio.toString();
        namecontroller.text = name.toString();

        return Scaffold(
          backgroundColor: widget.colorBW ? Colors.white : Colors.grey[800],
          appBar: AppBar(
            backgroundColor: widget.colorBW ? Colors.grey : Colors.black,
            elevation: 3,
            title: Text("Edit Profile",
                style: TextStyle(
                    color: widget.colorBW ? Colors.white : Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: showAlertBox,
                  child: pickedImage != null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(pickedImage!),
                        )
                      : CircleAvatar(
                          radius: 70,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                              imageUrl: image,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.person_2_outlined),
                            ),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 20,
                    color: widget.colorBW ? Colors.white : Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_2_outlined,
                            color: widget.colorBW ? Colors.black : Colors.white,
                          ),
                          label: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  widget.colorBW ? Colors.black : Colors.white,
                            ),
                          ),
                          hintText: 'Enter Name',
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.cyan,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color:
                                    widget.colorBW ? Colors.black : Colors.cyan,
                              ),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 20,
                    color: widget.colorBW ? Colors.white : Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: DOBcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter birthdate';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.calendar_month_outlined,
                            color: widget.colorBW ? Colors.black : Colors.white,
                          ),
                          label: Text(
                            birthdate == "" ? "Set BirthDate" : "BirthDate",
                            style: TextStyle(
                                color: widget.colorBW
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 15),
                          ),
                          //  hintText: birthdate == "" ? "Set BirthDate" : "BirthDate",
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color:
                                    widget.colorBW ? Colors.black : Colors.cyan,
                              ),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 20,
                    color: widget.colorBW ? Colors.white : Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: BIOcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' Enter Bio';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.info_outline,
                            color: widget.colorBW ? Colors.black : Colors.white,
                          ),
                          label: Text(
                            bio == "" ? "Set Bio" : "Bio",
                            style: TextStyle(
                                color: widget.colorBW
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 15),
                          ),
                          // hintText: bio == "" ? "Set Bio" : "Bio",
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color:
                                    widget.colorBW ? Colors.black : Colors.cyan,
                              ),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                // TxtF(
                //     textEditingController: DOBcontroller,
                //     hintText: "Enter Birthdate",
                //     prefixIcon: Icons.calendar_month_rounded),
                // TxtF(
                //     textEditingController: BIOcontroller,
                //     hintText: "Enter Bio",
                //     prefixIcon: Icons.message_outlined),
                const SizedBox(
                  height: 20,
                ),
                ElvB(
                  onTab: () {
                    if (DOBcontroller.text != "" &&
                        namecontroller.text != "" &&
                        BIOcontroller.text != "") {
                      update();
                      showSnackBar(context, "Updated Successfully.");
                    } else {
                      showSnackBar(context, "Enter Required Fields.");
                    }
                  },
                  text: "Update Profile",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
