import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/searchCriteria.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConferenceHallPage extends StatefulWidget {
  const ConferenceHallPage({Key? key}) : super(key: key);

  @override
  _ConferenceHallPageState createState() => _ConferenceHallPageState();
}

class _ConferenceHallPageState extends State<ConferenceHallPage> {
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
        title: Text('Conference Halls',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: primary)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please Specify Your Purpose',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    primary: primary,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: ()async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('spec', "businessMeeting");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchCriteria()));
                  },
                  child: Text(
                    "Business Meeting",
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
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    primary: primary,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('spec', "conference");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchCriteria()));
                  },
                  child: Text(
                    "Conference/Seminar",
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
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    primary: primary,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('spec', "productLaunch");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchCriteria()));
                  },
                  child: Text(
                    "Product Launch",
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
