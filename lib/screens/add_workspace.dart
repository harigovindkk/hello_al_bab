import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/model/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_al_bab/model/user_model.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_al_bab/widgets/workspace_request_card.dart';

class AddWorkspace extends StatefulWidget {
  const AddWorkspace({Key? key}) : super(key: key);

  @override
  _AddWorkspaceState createState() => _AddWorkspaceState();
}

class _AddWorkspaceState extends State<AddWorkspace> {
  TextEditingController otpcontroller = TextEditingController();
  Requests? myRequest;
  String recentstatus = "";
  //  bool _isLoading = true;
  Users? userDetail;

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
        userDetail =
            Users.fromJson(value.data() as Map<String, dynamic>) as Users;
      });
    }).whenComplete(() => setState(() {
              // print(userDetail!.profilePicture);
              isLoading = false;
            }));
  }

  Future<void> createRequestDoc() async {
    String requestId =
        FirebaseFirestore.instance.collection('addRequests').doc().id;
    await FirebaseFirestore.instance
        .collection('addRequests')
        .doc(requestId)
        .set({
      'type': "workspace",
      'requestId': requestId,
      'clientPhone': userDetail!.phone,
      'clientEmail': userDetail!.email,
      'status': 'requested',
      'time': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid
    }).onError((error, stackTrace) => print(error));
  }

  int? isLoggedin = null;

  loginChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedin = prefs.getInt('loggedin');
      isLoading = false;
    });
    print("isLoggedin = $isLoggedin");
  }

  bool isLoading = true;
  Widget bookingConfirmation(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Confirm Listing Request",
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Thank you for your interest, our team will contact you via email or phone with instructions to add a listing",
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "Cancel",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(customSnackBar("Request cancelled", Icons.check));
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: () {
            createRequestDoc().whenComplete(() => ScaffoldMessenger.of(context)
                .showSnackBar(customSnackBar(
                    "Request placed successfully", Icons.check)));
            Navigator.of(context).pop();
          },
          // textColor: Colors.black,
          child: Text("Ok",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              )),
        ),
      ],
    );
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    getDetails();
    loginChecker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(Icons.arrow_back_ios, color: primary),
        // ),
        elevation: 0,
        centerTitle: true,
        title: Text('Workspace Requests',
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
          : isLoggedin == 1
              ? SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('addRequests')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .where('type', isEqualTo: 'workspace')
                          .orderBy("time", descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: primary,
                          ));
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return Container(
                            height: MediaQuery.of(context).size.height*0.60,
                            child: Column(
                              children: [
                               SizedBox(height: MediaQuery.of(context).size.height*0.10 ),
                                Image.asset('images/no-data.jpg', height: MediaQuery.of(context).size.height*0.40),
                                 Center(
                                  child: Text(
                                    "No workspace requests to show!",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          recentstatus = snapshot.data!.docs.first['status'];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white60,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 7.0,
                                  spreadRadius: 2.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                            padding: const EdgeInsets.all(5),
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((doc) {
                                myRequest = Requests.fromDoc(doc.data() as Map);

                                return WorkSpaceRequestCard(
                                    myRequest as Requests);
                              }).toList(),
                            ),
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: customDecoration,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          style: customButtonStyle,
                          onPressed: () {
                            if (recentstatus == "requested" ||
                                (recentstatus == "processsing")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                      "You cannot place a new request if your latest request is not reviewed",
                                      Icons.warning_amber_rounded));
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    bookingConfirmation(context),
                              );
                            }
                          },
                          child: Text(
                            "Place New Request",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    //   Padding(
                    //     padding: const EdgeInsets.all(15.0),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.rectangle,
                    //         borderRadius: BorderRadius.circular(50.0),
                    //         gradient: const LinearGradient(
                    //             colors: <Color>[Color(0xffF9DB39), Color(0xffFFEF62)],
                    //             begin: FractionalOffset.topLeft,
                    //             end: FractionalOffset.bottomRight,
                    //             stops: [0.1, 0.4],
                    //             tileMode: TileMode.mirror),
                    //       ),
                    //       width: MediaQuery.of(context).size.width * 0.9,
                    //       child: ElevatedButton(
                    //         style: ElevatedButton.styleFrom(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(50.0)),
                    //           elevation: 0,
                    //           primary: Colors.transparent,
                    //           padding: const EdgeInsets.all(15),
                    //         ),
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => MyBookings()),
                    //           );
                    //         },
                    //         child: Text(
                    //           "Continue to Bookings",
                    //           style: GoogleFonts.poppins(
                    //               color: Colors.black,
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w600),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ],
                ))
              : Container(
                  child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Please Create an account to view your workspace requests",
                            style: GoogleFonts.poppins(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: customDecoration,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ElevatedButton(
                              style: customButtonStyle,
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
