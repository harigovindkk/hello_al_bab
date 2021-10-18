import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/model/wishlist_model.dart';
import 'package:hello_al_bab/widgets/workSpaceCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyWishlist extends StatefulWidget {
  @override
  _MyWishlistState createState() => _MyWishlistState();
}

class _MyWishlistState extends State<MyWishlist> {
  Wishlist? wishlistItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(123);
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
          "Wishlist",
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('wishlist')
                      .where('userId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      // .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: primary,
                      ));
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No Workspace in wishlist!",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 15),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((doc) {
                          wishlistItem = Wishlist.fromMap(
                              doc.data() as Map<String, dynamic>);
                          // print();
                          return WorkSpaceCard(
                            spaceId: wishlistItem!.spaceId,
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Unknown Error Occured!",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 15),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
