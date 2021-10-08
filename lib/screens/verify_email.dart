import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/home.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 50.0,
    content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: lightprimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.black),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text('OTP is Incorrect!',
                  style: GoogleFonts.poppins(color: Colors.black)),
            ),
          ],
        )),
  );

  TextEditingController otpcontroller = TextEditingController();
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
        title: Text('Verify Email',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: primary)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter the OTP sent to your Email ',
                  style: GoogleFonts.poppins(color: primary),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
              child: Text(
                "OTP",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                style: GoogleFonts.poppins(
                    color: primary, fontWeight: FontWeight.w600),
                cursorColor: primary,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "OTP can't be empty";
                  }
                  return null;
                },
                controller: otpcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '',
                  labelStyle:
                      GoogleFonts.poppins(color: const Color(0xff181818)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primary,
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
                      color: primary,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text(
                    "Verify",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                        text: 'Didn\'t recieve OTP ? ',
                        style:
                            GoogleFonts.poppins(fontSize: 15, color: primary),
                        children: [
                          TextSpan(
                            text: 'Resend OTP',
                            style: GoogleFonts.poppins(
                                color: primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {},
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
