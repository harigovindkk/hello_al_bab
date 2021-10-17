import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/model/bookings_model.dart';
import 'package:hello_al_bab/model/workspace_model.dart';
import 'package:hello_al_bab/screens/workspace_detail.dart';
import 'package:hello_al_bab/widgets/bookedWorkspace.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationAvailable extends StatefulWidget {
  final Workspace workspace;

  const LocationAvailable({Key? key, required this.workspace})
      : super(key: key);
  @override
  _LocationAvailableState createState() => _LocationAvailableState();
}

class _LocationAvailableState extends State<LocationAvailable> {
  bool checked = false;

  String? type;
  String? spec;

  _getSearchCriteria() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getString('type').toString();
      spec = prefs.getString('spec').toString();
      spec = prefs.getString('spec').toString();
    });
    print(type);
  }

  @override
  void initState() {
    super.initState();
    _getSearchCriteria();
  }

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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.workspace.description,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                ),
              ),
              BookedWorkSpaceCard(new Bookings(
                  bookId: "123",
                  userId: "userId",
                  toDate: Timestamp.now(),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkSpaceDetail(
                                workspace: widget.workspace,
                              )),
                    );
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
