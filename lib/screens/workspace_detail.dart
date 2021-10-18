// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/resources.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/model/workspace_model.dart';
import 'package:hello_al_bab/screens/bookings.dart';
import 'package:hello_al_bab/screens/home.dart';
import 'package:hello_al_bab/screens/searchCriteria.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkSpaceDetail extends StatefulWidget {
  final Workspace workspace;
  WorkSpaceDetail({Key? key, required this.workspace}) : super(key: key);

  @override
  _WorkSpaceDetailState createState() => _WorkSpaceDetailState();
}

class _WorkSpaceDetailState extends State<WorkSpaceDetail> {
  Workspace? workspace;
  int isLoggedIn = 0;
  bool isLoading = true;

  bool projectCheck = false;
  bool receptionCheck = false;
  bool foodCheck = false;
  bool pickCheck = false;

  String? type;
  String? spec;
  DateTime? fromDate;
  DateTime? toDate;
  DateTime? bookedFromDate;
  DateTime? bookedToDate;
  bool isSingleDay = false;
  String? selectedFromTime;
  String? selectedToTime;
  String bookedFromTime = '', bookedToTime = '';
  String status = '';

  _getSearchCriteria() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getString('type').toString();
      spec = prefs.getString('spec').toString();
      isSingleDay = prefs.getBool('isSingle') as bool;
    });
    if (isSingleDay) {
      setState(() {
        fromDate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(prefs.getString('fromDate').toString()));
        toDate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(prefs.getString('toDate').toString()));
        selectedFromTime = prefs.getString('fromTime');
        selectedToTime = prefs.getString('toTime');
      });
    } else {
      setState(() {
        fromDate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(prefs.getString('fromDate').toString()));
        toDate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(prefs.getString('toDate').toString()));
      });
    }
  }

  Future<void> getDetails() async {
    return FirebaseFirestore.instance
        .collection('workspace')
        .doc(widget.workspace.spaceId)
        .get()
        .then((value) {
      setState(() {
        workspace = Workspace.fromDoc(value.data() as Map<String, dynamic>);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    getDetails().whenComplete(() {
      setState(() {
        isLoading = false;
      });
      _getSearchCriteria();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? CircularProgressIndicator(
              color: primary,
            )
          : Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: primary,
                  ),
                  child: Image.network(
                    workspace!.photoUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(20, 1.5),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, left: 20, right: 20, bottom: 40),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              workspace!.name,
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primary),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              workspace!.address,
                              style: GoogleFonts.poppins(color: Colors.white38),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ExpandableText(
                              workspace!.description,
                              expandText: 'See More',
                              collapseText: 'See Less',
                              maxLines: 5,
                              style: GoogleFonts.poppins(color: Colors.white),
                              linkColor: primary,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Opening Timings',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primary),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Monday',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.workspace.time["mo-from"]} - ${widget.workspace.time["mo-to"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tuesday',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.workspace.time["tu-from"]} - ${widget.workspace.time["tu-to"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Wednesday',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.workspace.time["we-from"]} - ${widget.workspace.time["we-to"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Thursday',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.workspace.time["th-from"]} - ${widget.workspace.time["th-to"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Friday',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.workspace.time["fr-from"]} - ${widget.workspace.time["fr-to"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Saturday',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.workspace.time["sa-from"]} - ${widget.workspace.time["sa-to"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sunday',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${widget.workspace.time["su-from"]} - ${widget.workspace.time["su-to"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Text(
                                  'Facilities',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primary),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'WiFi',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            Text(
                              'Electricity',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            Text(
                              'Water',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            Text(
                              'Coffee',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Text(
                                  'Additional Facilities',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: primary),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Theme(
                                  data:
                                      ThemeData(unselectedWidgetColor: primary),
                                  child: Checkbox(
                                    value: projectCheck,
                                    onChanged: (newValue) {
                                      setState(() {
                                        projectCheck = newValue!;
                                      });
                                    },
                                    tristate: false,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        side: const BorderSide(
                                            color: Colors.white)),
                                    activeColor: boxColor,
                                    checkColor: primary,
                                  ),
                                ),
                                Text(
                                  "Projector",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Theme(
                                  data:
                                      ThemeData(unselectedWidgetColor: primary),
                                  child: Checkbox(
                                    value: receptionCheck,
                                    onChanged: (newValue) {
                                      setState(() {
                                        receptionCheck = newValue!;
                                      });
                                    },
                                    tristate: false,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        side: const BorderSide(
                                            color: Colors.white)),
                                    activeColor: boxColor,
                                    checkColor: primary,
                                  ),
                                ),
                                Text(
                                  "Reception",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Theme(
                                  data:
                                      ThemeData(unselectedWidgetColor: primary),
                                  child: Checkbox(
                                    value: foodCheck,
                                    onChanged: (newValue) {
                                      setState(() {
                                        foodCheck = newValue!;
                                      });
                                    },
                                    tristate: false,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        side: const BorderSide(
                                            color: Colors.white)),
                                    activeColor: boxColor,
                                    checkColor: primary,
                                  ),
                                ),
                                Text(
                                  "Food and drinks",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Theme(
                                  data:
                                      ThemeData(unselectedWidgetColor: primary),
                                  child: Checkbox(
                                    value: pickCheck,
                                    onChanged: (newValue) {
                                      setState(() {
                                        pickCheck = newValue!;
                                      });
                                    },
                                    tristate: false,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        side: const BorderSide(
                                            color: Colors.white)),
                                    activeColor: boxColor,
                                    checkColor: primary,
                                  ),
                                ),
                                Text(
                                  "Pick and drop",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  margin: EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(primary),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ))),
                                    child: Text(
                                      "Book Now",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () async {
                                      FirebaseFirestore.instance
                                          .collection('bookings')
                                          .doc()
                                          .set({
                                        "fromDate": fromDate,
                                        "fromTime": selectedFromTime,
                                        "isSingleDay": isSingleDay,
                                        "spaceId": workspace!.spaceId,
                                        "status": "booked",
                                        "timeStamp": Timestamp.now(),
                                        "toDate": toDate,
                                        "toTime": selectedToTime,
                                        "transactionId": "1231",
                                        "userId": FirebaseAuth
                                            .instance.currentUser!.uid,
                                        "spec": spec,
                                        "type": type
                                      }).whenComplete(() {
                                        print(123);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(customSnackBar(
                                                "Booking is completed successfully",
                                                Icons.check));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()),
                                        );
                                      });

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      isLoggedIn =
                                          await prefs.getInt('loggedin')!;
                                      print(isLoggedIn);
                                      if (isLoggedIn == 0) {
                                        print("please login");
                                      } else {
                                        print("loggein");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
