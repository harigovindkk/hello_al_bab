import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/model/workspace_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_al_bab/screens/searchCriteria.dart';
import 'package:hello_al_bab/widgets/workSpaceCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Workspace? workspace;
  String? type;
  String? spec;

  _getSearchCriteria() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getString('type').toString();
      spec = prefs.getString('spec').toString();
    });
    print(type);
  }

  @override
  void initState() {
    // TODO: implement initState
    _getSearchCriteria();
    super.initState();
    //print(123);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    "Search Results",
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('workspace')
                      .where('workspaceType', isEqualTo: type)
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
                          "No Workspace to show!",
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
                          workspace = Workspace.fromDoc(
                              doc.data() as Map<String, dynamic>);
                              // print();
                          return WorkSpaceCard(
                            spaceId: workspace!.spaceId,
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
            // const Spacer(),
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   margin: const EdgeInsets.all(10),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         primary: primary,
            //         padding: const EdgeInsets.all(10),
            //         shape: (RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //         ))),
            //     child: Text(
            //       "Your Search Criteria",
            //       style: GoogleFonts.poppins(
            //           color: Colors.black, fontWeight: FontWeight.w600),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => SearchCriteria()),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
