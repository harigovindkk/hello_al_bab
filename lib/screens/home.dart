import 'package:flutter/material.dart';
import 'package:hello_al_bab/screens/homePage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int page = 0;
  final pages = [HomePage(), HomePage(), HomePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined), label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_outlined),
              label: "Profile"),
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
    );
  }
}
