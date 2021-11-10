import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_al_bab/screens/home.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:hello_al_bab/screens/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? isLoggedin = null;
  loginChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedin = prefs.getInt('loggedin');
    });
  }

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  int isFirstTime = 1;
  Future<void> _isFirstTime() async {
    final SharedPreferences prefsData = await prefs;
    setState(() {
      isFirstTime = prefsData.getInt('isFirstTime') ?? 1;
    });
    print(isFirstTime == 1 ? "first time" : "not first time");
  }

  @override
  void initState() {
    _isFirstTime();
    super.initState();
    _mockCheckForSession().then((status) {
      if (status) {
        _isFirstTime();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      } else {
        print(isFirstTime);
        isFirstTime == 1 ? _navigateToFirstScreen() : _navigateToLogin();
      }
    });
  }

  // Future isUserExist() async {
  //   Future<QuerySnapshot<Map<String, dynamic>>> result = FirebaseFirestore
  //       .instance
  //       .collection('users')
  //       .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   result.then((value) {
  //     print(value.docs.length);
  //     if (value.docs.length > 0) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => HomePage(),
  //         ),
  //       );

  //     } else {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => CreateProfile(
  //             uid: FirebaseAuth.instance.currentUser!.uid,
  //           ),
  //         ),
  //       );
  //     }
  //   }).whenComplete(() => null);
  // }

  Future<bool> _mockCheckForSession() async =>
      await Future.delayed(Duration(milliseconds: 2000), () {
        return FirebaseAuth.instance.currentUser != null ? true : false;
      });

  void _navigateToFirstScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => OnBoardingScreen()));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/Dubai Desk Logo Final.jpg',
          width: MediaQuery.of(context).size.width * 0.35,
        ),
      ),
    );
  }
}
