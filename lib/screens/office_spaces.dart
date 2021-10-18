import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/searchCriteria.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfficeSpacePage extends StatefulWidget {
  const OfficeSpacePage({Key? key}) : super(key: key);

  @override
  _OfficeSpacePageState createState() => _OfficeSpacePageState();
}

class _OfficeSpacePageState extends State<OfficeSpacePage> {
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
        title: Text('Office Spaces',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please Specify The Area',
                    style: GoogleFonts.poppins(color: Colors.black)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Container(
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
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('spec', "20 sq.ft");
                    
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchCriteria()));
                  },
                  child: Text(
                    "20 sq.ft",
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
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('spec', "100 sq.ft");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchCriteria()));
                  },
                  child: Text(
                    "100 sq.ft",
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
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('spec', "500 sq.ft");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchCriteria()));
                  },
                  child: Text(
                    "500 sq.ft",
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
          ],
        ),
      ),
    );
  }
}
