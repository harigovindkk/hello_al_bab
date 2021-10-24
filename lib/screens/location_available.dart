import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/model/bookings_model.dart';
import 'package:hello_al_bab/model/workspace_model.dart';
import 'package:hello_al_bab/screens/workspace_detail.dart';
import 'package:hello_al_bab/widgets/booked_workspace.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/screens/home.dart';
import 'package:hello_al_bab/widgets/booking_workspace_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class LocationAvailable extends StatefulWidget {
  final Workspace workspace;

  const LocationAvailable({Key? key, required this.workspace})
      : super(key: key);
  @override
  _LocationAvailableState createState() => _LocationAvailableState();
}

class _LocationAvailableState extends State<LocationAvailable> {
  bool checked = false;
  bool isLoading = true;

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
  Bookings? booking;

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

  // TimeOfDay fromString(String time) {
  //   int hh = 0;
  //   if (time.endsWith('PM')) hh = 12;
  //   time = time.split(' ')[0];
  //   return TimeOfDay(
  //     hour: hh +
  //         int.parse(time.split(":")[0]) %
  //             24, // in case of a bad time format entered manually by the user
  //     minute: int.parse(time.split(":")[1]) % 60,
  //   );
  // }

  getAvailability() {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('spaceId', isEqualTo: widget.workspace.spaceId)
        .get()
        .then((value) {
      if (value.size > 0) {
        for (int i = 0; i < value.size; i++) {
          Timestamp f = value.docs[i].data()['fromDate'];
          bookedFromDate = f.toDate();
          Timestamp t = value.docs[i].data()['toDate'];
          bookedToDate = t.toDate();
          // print("fromDate : ${fromDate}");
          // print("toDate : ${toDate}");
          // print("bookedFromDate : ${bookedFromDate}");
          // print("bookedToDate : ${bookedToDate}");
          // print(bookedToDate!.isAfter(fromDate!));
          if (!isSingleDay) {
            if (bookedToDate!.isAfter(fromDate!) &&
                    bookedFromDate!.isBefore(fromDate!) ||
                bookedToDate!.isAfter(toDate!) &&
                    bookedFromDate!.isBefore(toDate!)) {
              setState(() {
                status = "Not Available";
              });
              break;
            } else {
              setState(() {
                status = "Available";
              });
            }
          } else {
            // print(123);
            // print((value.docs[i].data()['toTime']).toString().split(":")[0]);
            // print((value.docs[i].data()['toTime']).toString().split(" ")[0]);
            // String hour =
            //     value.docs[i].data()['toTime'].toString().split(":")[0];
            // int h = int.parse("$hour");
            // print("hour=$h");

            // String min =
            //     value.docs[i].data()['toTime'].toString().split(":")[0];
            print("single day");
            // Timestamp(hour:hour,)
            // print(TimeOfDay(hour: value.docs[i].data()['toTime'].split(":")[0], minute: 0), );

            if (bookedToDate!.isAfter(fromDate!) &&
                    bookedFromDate!.isBefore(fromDate!) ||
                bookedToDate!.isAfter(toDate!) &&
                    bookedFromDate!.isBefore(toDate!)) {
              setState(() {
                status = "Not Available";
              });
              break;
            } else {
              setState(() {
                status = "Available";
              });
            }
          }
        }
        print(status);
      } else {
        setState(() {
          status = "Available";
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getSearchCriteria();
    setState(() {
      isLoading = true;
    });
    getAvailability().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Location Availability",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 35,),
                    BookingWorkSpaceCard(
                        new Bookings(
                          bookId: "123",
                          userId: "",
                          toDate: Timestamp.fromDate(toDate!),
                          fromDate: Timestamp.fromDate(fromDate!),
                          type: type.toString(),
                          spec: spec.toString(),
                          spaceId: widget.workspace.spaceId,
                          isSingleDay: true,
                          status: "not booked",
                          transactionId: "transactionId",
                          timeStamp: Timestamp.now(),
                        ),
                        status),
                    SizedBox(
                      height: 75,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            "Booked Slots",
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: primary),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 1),
                          borderRadius: BorderRadius.circular(5),
                          shape: BoxShape.rectangle,
                        ),
                        //color:isDarkMode==1?darkModeBg: Colors.white,
                        //height: 170,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('bookings')
                                .where('spaceId',
                                    isEqualTo: widget.workspace.spaceId)
                                // .orderBy("date", descending: true)
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
                                return Center(
                                  child: Text(
                                    "No bookings to show!",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                return ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((doc) {
                                    Timestamp t = doc.get('fromDate');
                                    DateTime from = t.toDate();
                                    t = doc.get('toDate');
                                    DateTime to = t.toDate();
                                    return Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              doc.get('isSingleDay') == false
                                                  ? "${from.day} / ${from.month} / ${from.year} to ${to.day} / ${to.month} / ${to.year}"
                                                  : "${from.day} / ${from.month} / ${from.year}, ${doc.get('fromTime')} to ${doc.get('toTime')}",
                                              style: TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                    );
                                    // return ListTile(
                                    //   dense: true,
                                    //   trailing: Icon(Icons.check),
                                    //   title: Text(
                                    //       doc.get('isSingleDay') == false
                                    //           ? "${from.day} / ${from.month} / ${from.year} to ${to.day} / ${to.month} / ${to.year}"
                                    //           : "${from.day} / ${from.month} / ${from.year}, ${doc.get('fromTime')} to ${doc.get('toTime')}",
                                    //       style: TextStyle(color: Colors.black)),
                                    // );
                                  }).toList(),
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
                        ),
                      ),
                    ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         children: [
//                           Theme(
//                             data: ThemeData(unselectedWidgetColor: primary),
//                             child: Checkbox(
//                               value: checked,
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   checked = newValue!;
//                                 });
//                               },
//                               tristate: false,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(2),
//                                   side: const BorderSide(color: Colors.black)),
// // tristate: true,
//                               // shape: CircleBorder(),
//                               activeColor: boxColor,
//                               checkColor: primary,
//                             ),
//                           ),
//                           Text(
//                             "Agree to the terms and conditions",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 12, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
                    // const Spacer(),
                    SizedBox(
                      height: 35,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Booking Cost",
                    //       style: GoogleFonts.poppins(
                    //         fontSize: 18,
                    //         color: primary,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(30.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "Total",
                    //         style: GoogleFonts.poppins(
                    //           fontSize: 15,
                    //           color: primary,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //       Text(
                    //         "22 AED",
                    //         style: GoogleFonts.poppins(
                    //           fontSize: 15,
                    //           color: primary,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: LinearGradient(
                            colors: status == "Available"
                                ? <Color>[Color(0xffF9DB39), Color(0xffFFEF62)]
                                : <Color>[Colors.black12, Colors.black26],
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
                        child: Text(
                          "Book for 22 AED",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          if (status == "Available") {
                            // if (checked) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WorkSpaceDetail(
                                          workspace: widget.workspace,
                                        )));
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       customSnackBar(
                            //           "Please agree to the terms and conditions",
                            //           Icons.warning_amber_rounded));
                            // }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                    "Not Available at the requested time",
                                    Icons.warning_amber_rounded));
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
