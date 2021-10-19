import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/provider.dart';
import 'package:hello_al_bab/screens/home.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:hello_al_bab/services/authentication.dart';
import 'package:hello_al_bab/widgets/input_field.dart';
import 'package:intl/intl.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  User? user;
  Future isUserExist() async {
    Future<QuerySnapshot<Map<String, dynamic>>> result = FirebaseFirestore
        .instance
        .collection('users')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    result.then((value) {
      print("value=${value.docs.length}");
      if (value.docs.length > 0) {
        // Navigator.pop(context);
        Future<SharedPreferences> prefs = SharedPreferences.getInstance();
        final SharedPreferences prefsData = prefs as SharedPreferences;
        prefsData.setInt('loggedin', 1);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        //  Navigator.pop(context);
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "createdTime": Timestamp.now(),
          "dob": "",
          "email": user!.email,
          "phone": user!.phoneNumber,
          "profilePicture": user!.photoURL,
          "uid": FirebaseAuth.instance.currentUser!.uid,
          "name": user!.displayName
        });
      }
    }).whenComplete(() {
      Future<SharedPreferences> prefs = SharedPreferences.getInstance();
      final SharedPreferences prefsData = prefs as SharedPreferences;
      prefsData.setInt('loggedin', 1);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
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
CountryCode? code;
  Future<void> createUserDoc() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "loginMethord": "EmailAndPassword",
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "name": namecontroller.text,
      "email": emailcontroller.text,
      "dob": DateFormat(isSelected ? 'dd-MM-yyyy' : '').format(selectedDate),
      "phone": code.toString()+" "+phonecontroller.text,
      "profilePicture": '',
      "createdTime": Timestamp.now(),
    }).onError((error, stackTrace) => print(error));
  }

  TextEditingController emailcontroller = TextEditingController(),
      namecontroller = TextEditingController(),
      dobcontroller = TextEditingController(),
      phonecontroller = TextEditingController(),
      passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation:0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text('Sign Up',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color:  Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                    color:  Colors.black,
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
                        DateFormat(isSelected ? 'dd-MM-yyyy' : '')
                            .format(selectedDate),
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        color:  Colors.black,
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
                "Email",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InputField('', emailcontroller),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
              child: Text(
                "Country Code",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            CountryCodePicker(padding: const EdgeInsets.only(left: 15.0) ,
         onChanged: (value){
           setState(() {
             code=value;
           });
         },
         // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
         initialSelection: 'IT',
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
              child: Container(
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
                        color:  Colors.black,
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
                        color:  Colors.black,
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
              child: Text(
                "Password",
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                style: GoogleFonts.poppins(
                    color: Colors.black, fontWeight: FontWeight.w600),
                cursorColor:  Colors.black,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Password field can't be empty";
                  }
                  return null;
                },
                obscureText: true,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  labelText: '',
                  labelStyle:
                      GoogleFonts.poppins(color: const Color(0xff181818)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color:  Colors.black,
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
                      color:  Colors.black,
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
                      colors: <Color>[Color(0xffF9DB39), Color(0xffFFEF62)],
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
                    AuthenticationHelper()
                        .signUp(emailcontroller.text, passwordcontroller.text)
                        .then((result) {
                      if (result == null) {
                        createUserDoc();
                        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                            "A verification link has been sent to the email. Please login after clicking it",
                            Icons.mail_outline));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                                result, Icons.warning_amber_rounded));
                      }
                    });
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50.0),
                  gradient: const LinearGradient(
                      colors: <Color>[Color(0xffF9DB39), Color(0xffFFEF62)],
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
                  onPressed: () async {
                    final albabprovider =
                        Provider.of<HelloAlbabProvider>(context, listen: false);
                    user = await albabprovider.googleLogin(context);

                    print(user!.displayName.toString());
                    if (user != null) {
                      isUserExist();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Continue with Gmail",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
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
