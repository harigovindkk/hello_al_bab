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
    print(spec);
  }

    int? isLoggedin = null;

  loginChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedin = prefs.getInt('loggedin');
    });
    print("isLoggedin = $isLoggedin");
  }

  @override
  void initState() {
    // TODO: implement initState
    _getSearchCriteria();
    loginChecker();
    super.initState();
    //print(123);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Search Results",
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
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
                            color: Colors.black, fontSize: 15),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                      print("Length "+snapshot.data!.docs.length.toString());
                    return ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((doc) {
                        //print(doc['ownerId']);
                        workspace = Workspace.fromDoc(
                            doc.data() as Map<String, dynamic>);
                           
                             //print(workspace!.spaceId);
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
                            color: Colors.black, fontSize: 15),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
