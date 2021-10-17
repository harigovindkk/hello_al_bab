import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/provider.dart';
import 'package:hello_al_bab/screens/add_workspace.dart';
import 'package:hello_al_bab/screens/ejari_service.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:hello_al_bab/screens/office_booking.dart';
import 'package:hello_al_bab/services/login_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';


class OurServicesPage extends StatefulWidget {
  const OurServicesPage({Key? key}) : super(key: key);

  @override
  _OurServicesPageState createState() => _OurServicesPageState();
}

class _OurServicesPageState extends State<OurServicesPage> {
  int? isLoggedin = null;

  loginChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedin = prefs.getInt('loggedin');
    });
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    loginChecker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(Icons.arrow_back_ios, color: primary),
        // ),
        automaticallyImplyLeading: false,
        actions: [
          isLoggedin == 1
              ? IconButton(
                  icon: Icon(Icons.logout,color: primary,),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt('loggedin', 0);
                    final millionsprovider =
                        Provider.of<HelloAlbabProvider>(context, listen: false);
                    millionsprovider.logout(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                )
              : Container()
        ],
        centerTitle: true,
        title: Text('Our Services',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: primary)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                        MaterialPageRoute(
                            builder: (context) => const EjariServicePage()));
                  },
                  child: Text(
                    "Ejari Services",
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                    print("value=$isLoggedin");

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OfficeBookingPage()));
                  },
                  child: Text(
                    "Office Bookings",
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
