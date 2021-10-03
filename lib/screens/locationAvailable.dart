import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/widgets/bookedWorkspace.dart';
import 'package:hello_al_bab/widgets/workSpaceCard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationAvailable extends StatefulWidget {
  @override
  _LocationAvailableState createState() => _LocationAvailableState();
}

class _LocationAvailableState extends State<LocationAvailable> {
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
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Location Available",
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nibh duis montes, elementum viverra. Aliquet hendrerit ridiculus nulla.",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              ),
            ),
            BookedWorkSpaceCard(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: null,
                    activeColor: primary,
                    checkColor: primary,
                  ),
                  Text(
                    "Agree to the terms and conditions",
                    style:
                        GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
            Spacer(),
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
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primary,
                    padding: EdgeInsets.all(10),
                    shape: (RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))),
                child: Text(
                  "Book",
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
