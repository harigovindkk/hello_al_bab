import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/searchCriteria.dart';
import 'package:hello_al_bab/widgets/workSpaceCard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(123);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                ),
                child: Text(
                  "Search",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: primary),
                ),
              ),
            ],
          ),
          Column(
            children: [
              // WorkSpaceCard(),
              WorkSpaceCard(),
              // SizedBox(height: 10,),
              WorkSpaceCard(),
            ],
          ),
          Spacer(),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primary,
                    padding: EdgeInsets.all(10),
                    shape: (RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))),
                child: Text(
                  "Your Search Criteria",
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchCriteria()),
                  );
                },
              ))
        ],
      ),
    );
  }
}
