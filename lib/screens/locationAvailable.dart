import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/model/bookings_model.dart';
import 'package:hello_al_bab/widgets/bookedWorkspace.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/screens/home.dart';

class LocationAvailable extends StatefulWidget {
  @override
  _LocationAvailableState createState() => _LocationAvailableState();
}

class _LocationAvailableState extends State<LocationAvailable> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(123);
  }

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Location Available",
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, color: primary),
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
            BookedWorkSpaceCard(new Bookings(
                bookId: "123",
                userId: "userId",
                spaceId: "zd2IDN4FmEpGJfBDUyA2",
                isSingleDay: true,
                fromDate: Timestamp.now(),
                toDate: Timestamp.now(),
                status: "status",
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
                    style:
                        GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
            const Spacer(),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
