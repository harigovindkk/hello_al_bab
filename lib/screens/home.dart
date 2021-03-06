import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/add_workspace.dart';
import 'package:hello_al_bab/screens/search_result.dart';
import 'package:hello_al_bab/screens/our_services.dart';
import 'package:hello_al_bab/screens/profile.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int page = 0;
  final pages = [OurServicesPage(), AddWorkspace(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        unselectedItemColor: Colors.black38,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "Services"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.workspaces), label: "Add Workspace"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: "Profile"),
        ],
        currentIndex: page,
        onTap: (index) {
          //print(index);
          setState(() {
            page = index;
          });
        },
      ),
    );
  }
}
