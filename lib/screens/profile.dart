import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/bookings.dart';
import 'package:hello_al_bab/screens/wishlist.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController otpcontroller = TextEditingController();
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
        title: Text('Profile',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: primary)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/profilepic.JPG',
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.width * 0.5,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Name Here ',
            style: GoogleFonts.poppins(
                color: primary, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyBookings()),
                    );
                  },
                  child: Text('Bookings',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: primary)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black, side: BorderSide(color: primary)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyWishlist()),
                    );
                  },
                  child: Text('Wishlist',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: primary)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black, side: BorderSide(color: primary)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
