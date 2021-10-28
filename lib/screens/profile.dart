import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/model/user_model.dart';
import 'package:hello_al_bab/screens/bookings.dart';
import 'package:hello_al_bab/screens/edit_profile.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:hello_al_bab/screens/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImageFile;
  String? profileFileName, profileUrl;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  bool profilechanged = false, uploadComplete = false;
  bool isLoading = true;
  Users? user = null;
  //TextEditingController otpcontroller = TextEditingController();

  Future<void> getDetails() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        user = Users.fromJson(value.data() as Map<String, dynamic>);
      });
    });
  }

  void _fromgallery() async {
    final _picker = ImagePicker();

    PickedFile? pickedImageFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 3000,
        maxHeight: 4000);

    print(pickedImageFile);

    setState(() {
      profileFileName = pickedImageFile!.path.split('/').last;
      _profileImageFile = File(pickedImageFile.path);
      profilechanged = true;
      //profileremoved = false;
    });
  }

  void _fromCamera() async {
    final _picker = ImagePicker();
    PickedFile? pickedImageFile = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 3000,
        maxHeight: 4000);

    print(pickedImageFile);

    setState(() {
      profileFileName = pickedImageFile!.path.split('.').last;
      _profileImageFile = File(pickedImageFile.path);
      profilechanged = true;
    });
  }

  Future<void> uploadProfilePic() async {
    firebase_storage.Reference ref1 = storage.ref(
        'assets/${FirebaseAuth.instance.currentUser!.uid}/${FirebaseAuth.instance.currentUser!.uid}.$profileFileName');
    firebase_storage.UploadTask profilePicUploadTask =
        ref1.putFile(_profileImageFile as File);
    profilePicUploadTask.whenComplete(() async {
      profileUrl =
          await ref1.getDownloadURL().whenComplete(() => updateProfilePic());

      //print(profileUrl);
    }).catchError((onError) {
      print(onError);
    });
  }

  int? isLoggedin = null;

  loginChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedin = prefs.getInt('loggedin');
    });
    print("isLoggedin = $isLoggedin");
  }

  void updateProfilePic() async {
    try {
      setState(() {
        isLoading = true;
      });
      // ignore: curly_braces_in_flow_control_structures
      if (profilechanged)
        await uploadProfilePic().whenComplete(() {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'profilePicture': profileUrl}).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                "Profile Picture Updated Successfully", Icons.check));
          }).catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar("Failed to update picture: $error",
                      Icons.warning_amber_rounded)));
        });

      //-------------------------------------------
    } catch (e) {
      print("e");
    }
  }

  @override
  void initState() {
    //print(FirebaseAuth.instance.currentUser!.uid);
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    loginChecker();
    getDetails().whenComplete(() {
      // print("ProfilePic " + user!.profilePicture);
      setState(() {
        isLoading = false;
      });
    });
    if (isLoggedin == 1) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(Icons.arrow_back_ios, color: primary),
        // ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Profile',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: isLoggedin == 1
          ? isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                )
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: primary,
                      ));
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "User does not exist!",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 15),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      // recentstatus = snapshot.data!.docs.last['status'];
                      return ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((doc) {
                          Users userDetail = Users.fromJson(
                              doc.data() as Map<String, dynamic>);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  userDetail.profilePicture == ''
                                      ? const CircleAvatar(
                                          backgroundColor: primary,
                                          radius: 100,
                                          backgroundImage: AssetImage(
                                            'images/profilepic.JPG',
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: primary,
                                          radius: 100,
                                          backgroundImage: NetworkImage(
                                            userDetail.profilePicture,
                                          ),
                                        ),
                                ],
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     TextButton(onPressed: (){
                              //              showDialog<void>(
                              //                     context: context,
                              //                     //barrierDismissible: false, // user must tap button!
                              //                     builder: (BuildContext context) {
                              //                       return AlertDialog(
                              //                         backgroundColor: Colors.white,
                              //                         title: Text(
                              //                           'Change Profile Picture',
                              //                           style: GoogleFonts.poppins(
                              //                               fontWeight: FontWeight.bold,
                              //                               color: Colors.black),
                              //                           textAlign: TextAlign.left,
                              //                         ),
                              //                         content: SingleChildScrollView(
                              //                           child: ListBody(
                              //                             children: <Widget>[
                              //                               Text(
                              //                                   'It’s recommended to use a picture that’s at least 98 x 98 pixels and 2MB or less.',
                              //                                   style:
                              //                                       GoogleFonts.poppins(
                              //                                     color: Colors.black,
                              //                                   )),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                         actions: <Widget>[
                              //                           TextButton(
                              //                             child: Text(
                              //                                 'Select From Gallery',
                              //                                 style: GoogleFonts.poppins(
                              //                                     color: Colors.black)),
                              //                             onPressed: () {
                              //                               _fromgallery();
                              //                               Navigator.of(context).pop();
                              //                             },
                              //                           ),
                              //                           TextButton(
                              //                             child: Text('Take a Picture',
                              //                                 style: GoogleFonts.poppins(
                              //                                     color: Colors.black)),
                              //                             onPressed: () {
                              //                               _fromCamera();
                              //                               Navigator.of(context).pop();
                              //                             },
                              //                           ),
                              //                         ],
                              //                       );
                              //                     });
                              //           }, child: Text('Select Profile Picture')),
                              //           profilechanged?TextButton(onPressed: (){updateProfilePic();}, child: Text("Update Profile")):SizedBox(width: 0,)
                              //   ],
                              // ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                userDetail.name,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 50),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyBookings()),
                                        );
                                      },
                                      child: Text('My Bookings',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          side: const BorderSide(
                                              color: Colors.black)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyWishlist()),
                                        );
                                      },
                                      child: Text('My Wishlist',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          side: const BorderSide(
                                              color: Colors.black)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50.0, right: 50),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfile()),
                                      );
                                    },
                                    child: Text('Edit Profile',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        side: const BorderSide(
                                            color: Colors.black)),
                                  ))
                            ],
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Unknown Error Occured!",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 15),
                        ),
                      );
                    }
                  },
                )
          : Container(
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please Create an account to view your Profile",
                        style: GoogleFonts.poppins(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: customDecoration,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          style:customButtonStyle,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            "Go to sign in",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
    );
  }
}
