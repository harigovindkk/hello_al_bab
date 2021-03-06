import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/conference_hall.dart';
import 'package:hello_al_bab/screens/coworking.dart';
import 'package:hello_al_bab/screens/meeting_room.dart';
import 'package:hello_al_bab/screens/office_spaces.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_al_bab/screens/virtual_office.dart';

class OfficeBookingPage extends StatefulWidget {
  const OfficeBookingPage({Key? key}) : super(key: key);

  @override
  _OfficeBookingPageState createState() => _OfficeBookingPageState();
}

class _OfficeBookingPageState extends State<OfficeBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text('Office Bookings',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Container(
                decoration:customDecoration,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: customButtonStyle,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('type', "Conference Hall");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConferenceHallPage()));
                  },
                  child: Text(
                    "Conference Halls",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Container(
                decoration:customDecoration,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: customButtonStyle,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('type', "Meeting Room");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MeetingRoomPage()));
                  },
                  child: Text(
                    "Meeting Rooms",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Container(
                 decoration:customDecoration,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: customButtonStyle,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('type', "Office Space");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OfficeSpacePage()));
                  },
                  child: Text(
                    "Office Space",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Container(
                decoration:customDecoration,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: customButtonStyle,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('type', "Coworking Space");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CoworkingPage()));
                  },
                  child: Text(
                    "Coworking Space",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Container(
                decoration: customDecoration,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: customButtonStyle,
                  onPressed: () async{
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('type', "virtualOffice");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VirtualOfficePage()));
                  },
                  child: Text(
                    "Virtual Offices",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
