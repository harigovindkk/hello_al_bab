// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/model/workspace_model.dart';
import 'package:hello_al_bab/screens/home.dart';
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
  List additionalFacilities = [];
  TextEditingController specialRequest = TextEditingController(text: "");

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
      backgroundColor: Colors.white,
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
                        color: Colors.white,
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
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ExpandableText(
                              workspace!.description,
                              expandText: 'See More',
                              collapseText: 'See Less',
                              maxLines: 5,
                              style: GoogleFonts.poppins(color: Colors.black54),
                              linkColor: Colors.black87,
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
                                      'Week Days',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "${widget.workspace.time["mo-from"]} - ${widget.workspace.time["mo-to"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Weekend Days',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "${widget.workspace.time["fr-from"]} - ${widget.workspace.time["fr-to"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black),
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
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                            Text(
                              'Electricity',
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                            Text(
                              'Water',
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                            Text(
                              'Coffee',
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Text(
                                  'Additional Facilities',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
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
                                            color: Colors.black)),
                                    activeColor: boxColor,
                                    checkColor: primary,
                                  ),
                                ),
                                Text(
                                  "Projector",
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
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
                                            color: Colors.black)),
                                    activeColor: boxColor,
                                    checkColor: primary,
                                  ),
                                ),
                                Text(
                                  "Reception",
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
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
                                            color: Colors.black)),
                                    activeColor: boxColor,
                                    checkColor: primary,
                                  ),
                                ),
                                Text(
                                  "Food and drinks",
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
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
                                            color: Colors.black)),
                                    activeColor: boxColor,
                                    checkColor: primary,
                                  ),
                                ),
                                Text(
                                  "Pick and drop",
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: TextFormField(
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                  cursorColor: Colors.black,
                                  maxLines: 2,
                                  controller: specialRequest,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    isDense: true,
                                    labelText: 'Special requests',
                                    labelStyle: GoogleFonts.poppins(
                                        color: const Color(0xff181818)),
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
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      elevation: 0,
                                      primary: Colors.transparent,
                                      padding: const EdgeInsets.all(15),
                                    ),
                                    child: Text(
                                      "Book Now",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () async {
                                      if (projectCheck) {
                                        additionalFacilities.add("Projector");
                                      }
                                      if (receptionCheck) {
                                        additionalFacilities.add("Reception");
                                      }
                                      if (foodCheck) {
                                        additionalFacilities
                                            .add("Food and drinks");
                                      }
                                      if (pickCheck) {
                                        additionalFacilities
                                            .add("Pick and drop");
                                      }
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
                                        "type": type,
                                        "facilities": [
                                          "Wifi",
                                          "Electricity",
                                          "Water",
                                          "Coffee"
                                        ],
                                        "additionalFacilities":
                                            additionalFacilities,
                                        "specialRequests": specialRequest.text
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
                            SizedBox(height: 20,)
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
