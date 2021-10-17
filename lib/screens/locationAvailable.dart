import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/model/bookings_model.dart';
import 'package:hello_al_bab/model/workspace_model.dart';
import 'package:hello_al_bab/screens/workspace_detail.dart';
import 'package:hello_al_bab/widgets/bookedWorkspace.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  getAvailability() {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('spaceId', isEqualTo: widget.workspace.spaceId)
        .get()
        .then((value) {
      if (value.size > 0) {
        for (int i = 0; i < value.size; i++) {
          // bookedFromDate = (
          //     ;
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
                bookedFromDate!.isBefore(fromDate!)) {
              setState(() {
                status = "Not Available";
              });
              break;
            } else {
              setState(() {
                status = "Available";
              });
            }
          }else{
            print(selectedFromTime);
            print(selectedToTime);
            String? bookedFromTime = value.docs[i].data()['fromTime'];
            String? bookedToTime = value.docs[i].data()['toTime'];
            
            
          }
        }
      } else {
        setState(() {
          status = "Not Available";
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Location " + status,
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, color: primary),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                color: Colors.black,
                child: Column(
                  children: [
                    BookedWorkSpaceCard(new Bookings(
                        bookId: "123",
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        toDate: Timestamp.fromDate(toDate!),
                        fromDate: Timestamp.now(),
                        spaceId: widget.workspace.spaceId,
                        isSingleDay: true,
                        status: "not booked",
                        transactionId: "transactionId",
                        timeStamp: Timestamp.now())),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Theme(
                            data: ThemeData(unselectedWidgetColor: primary),
                            child: Checkbox(
                              value: checked,
                              onChanged: (newValue) {
                                setState(() {
                                  checked = newValue!;
                                });
                              },
                              tristate: false,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  side: const BorderSide(color: Colors.white)),
// tristate: true,
                              // shape: CircleBorder(),
                              activeColor: boxColor,
                              checkColor: primary,
                            ),
                          ),
                          Text(
                            "Agree to the terms and conditions",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cost Breakdown",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: primary,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "22 AED",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primary,
                            padding: const EdgeInsets.all(10),
                            shape: (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        child: Text(
                          "Book",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          if (status == "Available") {
                            if (checked) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WorkSpaceDetail(
                                          workspace: widget.workspace,
                                        )),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                      "Please agree to the terms and conditions",
                                      Icons.warning_amber_rounded));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(
                                    "Not Available at the requested time",
                                    Icons.warning_amber_rounded));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
