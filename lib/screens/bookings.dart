import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/model/bookings_model.dart';
import 'package:hello_al_bab/widgets/bookedWorkspace.dart';
import 'package:hello_al_bab/widgets/workSpaceCard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  Bookings? booking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(123);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Bookings",
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, color: primary),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Column(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('bookings')
                        .where('userId',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)

                        // .orderBy("date", descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                color: Colors.white, fontSize: 15),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        
                        return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((doc) {
                            booking = Bookings.fromJson(
                                doc.data() as Map<String, dynamic>);
                                
                            return BookedWorkSpaceCard(booking);
                          }).toList(),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Unknown Error Occured!",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 15),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
