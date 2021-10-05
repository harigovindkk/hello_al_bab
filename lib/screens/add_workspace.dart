import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/model/bookings_model.dart';
import 'package:hello_al_bab/screens/bookings.dart';

class AddWorkspace extends StatefulWidget {
  const AddWorkspace({Key? key}) : super(key: key);

  @override
  _AddWorkspaceState createState() => _AddWorkspaceState();
}

class _AddWorkspaceState extends State<AddWorkspace> {
  TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(Icons.arrow_back_ios, color: primary),
        // ),
        centerTitle: true,
        title: Text('Add Workspace',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: primary)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/success.JPG',
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Thank you for your interest.\nOur team will contact you via email with\n instructions to add a listing',
                    style: GoogleFonts.poppins(color: primary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
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
                      MaterialPageRoute(builder: (context) => MyBookings()),
                    );
                    },
                    child: Text(
                      "Continue to Bookings",
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
      ),
    );
  }
}
