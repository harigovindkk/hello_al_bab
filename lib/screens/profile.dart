import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/model/user_model.dart';
import 'package:hello_al_bab/screens/bookings.dart';
import 'package:hello_al_bab/screens/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  Users? user = null;
  //TextEditingController otpcontroller = TextEditingController();

  Future<void> getDetails() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        user = Users.fromJson(value.data() as Map<String, dynamic>);
      });
    });
  }

  @override
  void initState() {
    //print(FirebaseAuth.instance.currentUser!.uid);
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    getDetails().whenComplete(() {
      //print("Username " +user!.name);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: const Icon(Icons.arrow_back_ios, color: primary),
        // ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Profile',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    user!.profilePicture == ''
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              'images/profilepic.JPG',
                              fit: BoxFit.fill,
                              height: MediaQuery.of(context).size.width * 0.3,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              user!.profilePicture,
                              fit: BoxFit.fill,
                              height: MediaQuery.of(context).size.width * 0.3,
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  user!.name,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
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
                            MaterialPageRoute(
                                builder: (context) => const MyBookings()),
                          );
                        },
                        child: Text('My Bookings',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: const BorderSide(color: Colors.black)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyWishlist()),
                          );
                        },
                        child: Text('My Wishlist',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: const BorderSide(color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
