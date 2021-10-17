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
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Location Available",
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.workspace.description,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
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
                      data: ThemeData(unselectedWidgetColor: Colors.black),
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
                        checkColor: Colors.white,
                      ),
                    ),
                    Text(
                      "Agree to the terms and conditions",
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: Colors.black),
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
                      color: Colors.black,
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
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "22 AED",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50.0),
                  gradient: const LinearGradient(
                      colors: <Color>[Color(0xffF9DB39), Color(0xffFFEF62)],
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
