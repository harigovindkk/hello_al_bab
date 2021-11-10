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
import 'package:hello_al_bab/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

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
    if (isLoggedin == 1) getDetails();
  }

  bool isLoading = false;
  Users? user = null;
  String loginMethod = "";
  //TextEditingController otpcontroller = TextEditingController();

  Future<void> getDetails() async {
    setState(() {
      isLoading = true;
    });
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        user = Users.fromJson(value.data() as Map<String, dynamic>);
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget ensureLogout(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Confirm Logout",
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Do you really wish to Sign Out?",
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "No",
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        TextButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setInt('loggedin', 0);
            // FirebaseAuth.instance.signOut();
            if (user!.loginMethod == "GoogleSignIn") {
              print(user!.loginMethod);
              FirebaseAuth.instance.signOut();
              Restart.restartApp();

              // final helloAlBabProvider =
              //     Provider.of<HelloAlbabProvider>(context, listen: false);
              // helloAlBabProvider.logout(context);
            } else {
              AuthenticationHelper().signOut();
            }

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          //textColor: Colors.black,
          child: Text("Yes",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  int isdarkmode = 0;
  @override
  initState() {
    // TODO: implement initState
    super.initState();

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: primary,
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  isLoggedin == 1
                      ? Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text('Hi, ${user!.name.split(' ')[0]}!',
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.black)),
                        )
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text('Welcome Guest!',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white60,
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 7.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                      child: Column(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Container(
                        decoration: customDecoration,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          style: customButtonStyle,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EjariServicePage()));
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
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Container(
                        decoration: customDecoration,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          style: customButtonStyle,
                          onPressed: () {
                            print("value=$isLoggedin");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OfficeBookingPage()));
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
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/Dubai Desk Logo Final.jpg',
                            width: MediaQuery.of(context).size.width * 0.35,
                          ),
                        ],
                      ),
                    ),
                  ])),
                ],
              ),
            ),
    );
  }
}
