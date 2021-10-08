import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:hello_al_bab/services/authentication.dart';
import 'package:hello_al_bab/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailcontroller = TextEditingController(),
      passwordcontroller = TextEditingController();

  Future<void> reset() async {
    try {
      await AuthenticationHelper().resetPassword(emailcontroller.text);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(e.message as String, Icons.warning_amber_rounded));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: primary),
        ),
        centerTitle: true,
        title: Text('Forgot Password',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: primary)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
              child: Text(
                "Email",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InputField('', emailcontroller),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    primary: primary,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {
                    if (emailcontroller.text.contains('@') == false ||
                        emailcontroller.text.contains('.') == false) {
                      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                          "Enter a valid Email ID",
                          Icons.warning_amber_rounded));
                    } else {
                      reset();
                      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                          "Password reset link sent to " + emailcontroller.text,
                          Icons.warning_amber_rounded));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    }
                  },
                  child: Text(
                    "Send Password Reset Link",
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
