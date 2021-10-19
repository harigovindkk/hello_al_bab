import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/provider.dart';
import 'package:hello_al_bab/screens/completeprofile.dart';
import 'package:hello_al_bab/screens/forgot_password.dart';
import 'package:hello_al_bab/screens/home.dart';
import 'package:hello_al_bab/screens/office_booking.dart';
import 'package:hello_al_bab/screens/our_services.dart';
import 'package:hello_al_bab/screens/signup.dart';
import 'package:hello_al_bab/services/authentication.dart';
import 'package:hello_al_bab/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _buildSignUpPop(BuildContext context) {
    return new AlertDialog(
      title: Text(
        "Account doesn't exist",
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "There is no account exist with this email id. Please sign up for new account.",
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: primary,
          child: Text(
            "Close",
            style: GoogleFonts.poppins(),
          ),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ),
            );
          },
          textColor: primary,
          child: Text("Goto sign up", style: GoogleFonts.poppins()),
        ),
      ],
    );
  }

  void setLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('loggedin', 1);
  }

  TextEditingController emailcontroller = TextEditingController(),
      passwordcontroller = TextEditingController();
  User? user;
  Future isUserExist() async {
    Future<QuerySnapshot<Map<String, dynamic>>> result = FirebaseFirestore
        .instance
        .collection('users')
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    result.then((value) async {
      if (value.docs.length > 0) {
        // Navigator.pop(context);
        print("account exists");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('loggedin', 1);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        //  Navigator.pop(context);
        print("account doesnot exist");
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "createdTime": Timestamp.now(),
          "dob": "",
          "email": user!.email,
          "phone": user!.phoneNumber == null ? "" : user!.phoneNumber,
          "profilePicture": user!.photoURL,
          "uid": FirebaseAuth.instance.currentUser!.uid,
          "name": user!.displayName,
          "loginMethod":"GoogleSignIn"
        }).whenComplete(() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('loggedin', 1);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CompleteProfile(userDetail: user as User,),
            ),
          );
        });
      }
    });
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
        centerTitle: true,
        title: Text('Sign In',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black)),
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
                cursorColor: Colors.black,
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
                    if (emailcontroller.text.contains('@') == false ||
                        emailcontroller.text.contains('.') == false) {
                      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                          "Enter a valid Email ID",
                          Icons.warning_amber_rounded));
                    } else if (passwordcontroller.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                          "Password cannot be null",
                          Icons.warning_amber_rounded));
                    } else {
                      AuthenticationHelper()
                          .signIn(emailcontroller.text, passwordcontroller.text)
                          .then((result) {
                        if (result == null) {
                          if (FirebaseAuth
                              .instance.currentUser!.emailVerified) {
                            setLoggedIn();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                    "Email not verified! Please check your mailbox",
                                    Icons.warning_amber_rounded));
                            AuthenticationHelper().signOut();
                            emailcontroller.clear();
                            passwordcontroller.clear();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar(
                                  result, Icons.warning_amber_rounded));
                          //  Scaffold.of(context).showSnackBar(SnackBar(
                          //      content: Text(
                          //      result,
                          //     style: TextStyle(fontSize: 16),
                          //        ),
                          //   ));
                        }
                      });
                    }
                  },
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
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
                   User? user1 = await albabprovider.googleLogin(context);
                    if (user1 != null) {
                      print(123);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()));
                    //reset();
                    // AuthenticationHelper().resetPassword(emailcontroller.text);
                  },
                  child: Text('Forgot Password?',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account ? ',
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage()))
                                  },
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Text(
                    'Skip and continue as a guest ',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                ),
                const Icon(Icons.arrow_forward, color: Colors.black),
              ],
            )
          ],
        ),
      ),
    );
  }
}
