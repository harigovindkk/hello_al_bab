import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/model/user_model.dart';
import 'package:hello_al_bab/widgets/input_field.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Users? userDetail;

  Future<void> getDetails() async {
    setState(() {
      _isLoading = true;
    });
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userDetail =
            Users.fromJson(value.data() as Map<String, dynamic>) as Users;
      });
    }).whenComplete(() => setState(() {
              // print(userDetail!.profilePicture);
              _isLoading = false;
            }));
  }

  CountryCode? code;
  File? _profileImageFile;
  bool profileremoved = false,
      profilechanged = false,
      uploadComplete = false,
      _isLoading = false,
      countryCodeSelected = false;

  String? profileFileName, profileUrl;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void _fromgallery() async {
    final _picker = ImagePicker();

    PickedFile? pickedImageFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 3000,
        maxHeight: 4000);

    //print(fileName);

    setState(() {
      profileFileName = pickedImageFile!.path.split('.').last;
      _profileImageFile = File(pickedImageFile.path);
      profilechanged = true;
      //profileremoved = false;
      uploadComplete = true;
    });
  }

  void _fromCamera() async {
    final _picker = ImagePicker();
    PickedFile? pickedImageFile = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 3000,
        maxHeight: 4000);

    // print(fileName);

    setState(() {
      profileFileName = pickedImageFile!.path.split('.').last;
      _profileImageFile = File(pickedImageFile.path);
      profilechanged = true;
      //profileremoved = false;

      uploadComplete = true;
    });
  }

  Future<firebase_storage.TaskSnapshot> uploadProfilePic() async {
    firebase_storage.Reference ref1 = storage.ref(
        'assets/${FirebaseAuth.instance.currentUser!.uid}/${FirebaseAuth.instance.currentUser!.uid}.$profileFileName');
    firebase_storage.UploadTask profilePicUploadTask =
        ref1.putFile(_profileImageFile as File);
    return profilePicUploadTask.whenComplete(() async {
      profileUrl = await ref1.getDownloadURL();
      //print(profileUrl);
    }).catchError((onError) {
      print(onError);
    });
  }

  DateTime selectedDate = DateTime.now();
  bool isSelected = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primary,
            accentColor: lightprimary,
            colorScheme: ColorScheme.dark(
              primary: primary,
              onPrimary: lightprimary,
              surface: primary,
              onSurface: Colors.black,
            ),
          ),
          child: child as Widget,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        isSelected = true;
        selectedDate = pickedDate;
      });
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Future<void> createUserDoc() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .set({
  //     "name": namecontroller.text,
  //     "dob": DateFormat(isSelected ? 'dd-MM-yyyy' : '').format(selectedDate),
  //     "phone": phonecontroller.text,
  //     "profilePicture": '',
  //   }).onError((error, stackTrace) => print(error));
  // }

  TextEditingController emailcontroller = TextEditingController(),
      namecontroller = TextEditingController(),
      dobcontroller = TextEditingController(),
      phonecontroller = TextEditingController(text: ""),
      passwordcontroller = TextEditingController();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getDetails().whenComplete(() {
      namecontroller.text = userDetail!.name;
      emailcontroller.text = userDetail!.email;
      selectedDate = DateFormat('dd-mm-yyyy').parse(userDetail!.dob);
      phonecontroller.text =
          userDetail!.phone.substring(userDetail!.phone.indexOf(' ') + 1);
    });
    // loginChecker();
    //print(FirebaseAuth.instance.currentUser);
  }

  void updateProfile() async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (profilechanged) await uploadProfilePic();
      FirebaseFirestore.instance
          .collection('users')
          .doc(userDetail!.uid)
          .update({
        'name': namecontroller.text,
        "dob": DateFormat('dd-MM-yyyy').format(selectedDate),
        "phone": countryCodeSelected
            ? code.toString() + " " + phonecontroller.text
            : userDetail!.phone.substring(0, userDetail!.phone.indexOf(' ')) +" "+
                phonecontroller.text,
        'profilePicture': profilechanged
            ? (profileremoved ? "" : profileUrl)
            : userDetail!.profilePicture,
      }).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar("Profile  Updated Successfully", Icons.check));
              Navigator.pop(context);
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) =>
              //-------------------------------------------
              ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                  "Failed to update profile: ${error}",
                  Icons.warning_amber_rounded)));
    } catch (e) {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text('Edit Profile',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: primary,
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Text(
                      "Email",
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      cursorColor: Colors.black87,
                      enabled: false,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle:
                            GoogleFonts.poppins(color: const Color(0xff181818)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                            bottomLeft: Radius.circular(4.0),
                            bottomRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                            bottomLeft: Radius.circular(4.0),
                            bottomRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Text(
                      "Name",
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: InputField('', namecontroller),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Text(
                      "Date Of Birth",
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ), //BorderRadi
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('dd-MM-yyyy').format(selectedDate),
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today),
                              color: Colors.black,
                              onPressed: () {
                                _selectDate(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Text(
                      "Country Code",
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ),
                  CountryCodePicker(
                    padding: const EdgeInsets.only(left: 15.0),
                    onChanged: (value) {
                      setState(() {
                        countryCodeSelected = true;
                        code = value;
                      });
                    },
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: 
                      userDetail!.phone.substring(0, userDetail!.phone.indexOf(' ')),
                        
                    // optional. Shows only country name and flag
                    showCountryOnly: false,
                    // optional. Shows only country name and flag when popup is closed.
                    showOnlyCountryWhenClosed: false,
                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Text(
                      "Phone Number(Without Country Code)",
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      cursorColor: Colors.black87,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Phone Number can't be empty";
                        }
                        return null;
                      },
                      obscureText: false,
                      controller: phonecontroller,
                      decoration: InputDecoration(
                        labelText: '',
                        labelStyle:
                            GoogleFonts.poppins(color: const Color(0xff181818)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                            bottomLeft: Radius.circular(4.0),
                            bottomRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                            bottomLeft: Radius.circular(4.0),
                            bottomRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Profile Pic",
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    // IconButton(
                                    //     onPressed: () {
                                    //       setState(() {
                                    //         artremoved = true;
                                    //         //artchanged=true;
                                    //       });
                                    //     },
                                    //     icon: Icon(
                                    //         Icons.delete_forever_rounded)),
                                    IconButton(
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            //barrierDismissible: false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Text(
                                                  'Change Profile Picture',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primary),
                                                  textAlign: TextAlign.left,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(
                                                          'For the best results on all devices, use an image that’s at least 2048 x 1152 pixels and 6MB or less.',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text(
                                                        'Select from Gallery',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black)),
                                                    onPressed: () {
                                                      _fromgallery();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  // TextButton(
                                                  //   child: Text(
                                                  //       'Take a Picture',
                                                  //       style:
                                                  //           GoogleFonts.poppins(
                                                  //               color: Colors
                                                  //                   .black)),
                                                  //   onPressed: () {
                                                  //     _fromCamera();
                                                  //     Navigator.of(context)
                                                  //         .pop();
                                                  //   },
                                                  // ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.edit,
                                            color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                            profilechanged
                                ? Image.file(_profileImageFile as File)
                                : (profileremoved
                                    ? Text(
                                        "Profile Pic Removed",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                      )
                                    : ((userDetail!.profilePicture.isEmpty)
                                        ? Text(
                                            "No Profile Pic",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                            ),
                                          )
                                        : Image.network(
                                            userDetail!.profilePicture)))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: const LinearGradient(
                            colors: <Color>[
                              Color(0xffF9DB39),
                              Color(0xffFFEF62)
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight,
                            stops: [0.1, 0.4],
                            tileMode: TileMode.mirror),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          elevation: 0,
                          primary: Colors.transparent,
                          padding: const EdgeInsets.all(15),
                        ),
                        onPressed: () {
                          updateProfile();
                        },
                        child: Text(
                          "Update Profile",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
