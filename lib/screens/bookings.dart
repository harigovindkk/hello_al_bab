import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/widgets/bookedWorkspace.dart';
import 'package:hello_al_bab/widgets/workSpaceCard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(123);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left:10),
          icon: Icon(Icons.arrow_back_ios,size: 20, color: primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Bookings",
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, color: primary),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Column(
              children: [
                BookedWorkSpaceCard(),
                BookedWorkSpaceCard(),
                BookedWorkSpaceCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
