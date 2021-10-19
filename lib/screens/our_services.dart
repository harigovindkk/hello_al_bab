import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/model/user_model.dart';
import 'package:hello_al_bab/provider.dart';
import 'package:hello_al_bab/screens/add_workspace.dart';
import 'package:hello_al_bab/screens/ejari_service.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:hello_al_bab/screens/office_booking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';

class OurServicesPage extends StatefulWidget {
  const OurServicesPage({Key? key}) : super(key: key);

  @override
  _OurServicesPageState createState() => _OurServicesPageState();
}

class _OurServicesPageState extends State<OurServicesPage> {
  int? isLoggedin = null;

  loginChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedin = prefs.getInt('loggedin');
    });
  }
  bool isLoading=false;
    Users? user = null;
  //TextEditingController otpcontroller = TextEditingController();

  Future<void> getDetails() async {
    setState(() {
      isLoading=true;
    });
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        user = Users.fromJson(value.data() as Map<String, dynamic>);
      });
    }).whenComplete((){
       setState(() {
      isLoading=false;
    });
    });
  }
  


  Widget ensureLogout(BuildContext context) {
    return new AlertDialog(
      title: Text(
        "Confirm Logout",
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Are you sure to sign out?",
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.black,
          child: Text(
            "No",
            style: GoogleFonts.poppins(),
          ),
        ),
        new FlatButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setInt('loggedin', 0);
            FirebaseAuth.instance.signOut().whenComplete(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            });
          },
          textColor: Colors.black,
          child: Text("Yes", style: GoogleFonts.poppins()),
        ),
      ],
    );
  }

  int isdarkmode = 0;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
    loginChecker();
    //print(FirebaseAuth.instance.currentUser);
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
        actions: [
          isLoggedin == 1
              ? TextButton(
                  child: Text("Logout",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w500)),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ensureLogout(context),
                    );
                  },
                )
              : Container()
        ],
        centerTitle: true,
        title: Text('Our Services',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: isLoading?Center(child: CircularProgressIndicator(color: primary,)):   SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isLoggedin == 1
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                            'Hi, ${user!.name}!',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black)),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('Welcome!',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black)),
                      ),
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EjariServicePage()));
                  },
                  child: Text(
                    "Ejari Services",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                    print("value=$isLoggedin");

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OfficeBookingPage()));
                  },
                  child: Text(
                    "Office Bookings",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
             Padding( padding: EdgeInsets.only( top: 80),
               child: Row(
                 
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset(
                       'images/Dubai Desk Logo.png',
                       width: MediaQuery.of(context).size.width * 0.25,
                     ),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }
}
