import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/constants/snackbar.dart';
import 'package:hello_al_bab/model/request_model.dart';
import 'package:hello_al_bab/screens/bookings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_al_bab/widgets/workspace_request_card.dart';

class VirtualOfficePage extends StatefulWidget {
  const VirtualOfficePage({Key? key}) : super(key: key);

  @override
  _VirtualOfficePageState createState() => _VirtualOfficePageState();
}

class _VirtualOfficePageState extends State<VirtualOfficePage> {
  TextEditingController otpcontroller = TextEditingController();
  Requests? myRequest;
  String recentstatus = "";
  Future<void> createRequestDoc() async {
    await FirebaseFirestore.instance.collection('addRequests').doc().set({
      'type' : "virtual office",
      'status': 'requested',
      'time': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid
    }).onError((error, stackTrace) => print(error));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        title: Text('Virtual Office',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: primary)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('addRequests')
                .where('userId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where('type', isEqualTo: 'virtual office')

                //  .orderBy("date", descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: primary,
                ));
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No office requests to show!",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                  ),
                );
              }
              if (snapshot.hasData) {
                recentstatus = snapshot.data!.docs.last['status'];
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    myRequest = Requests.fromDoc(doc.data() as Map);
                    return WorkSpaceRequestCard(myRequest as Requests);
                  }).toList(),
                );
              } else {
                return Center(
                  child: Text(
                    "Unknown Error Occured!",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 15),
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
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  primary: recentstatus == "requested" ? lightprimary : primary,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  if (recentstatus == "requested" ||
                      (recentstatus == "processsing")) {
                    ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                        "You cannot place a new request if your latest request is not reviewed",
                        Icons.warning_amber_rounded));
                  } else {
                    createRequestDoc().whenComplete(() =>
                        ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                                "Request placed successfully", Icons.check)));
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
      )),
    );
  }
}
