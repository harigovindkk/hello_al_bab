import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginChecker {
  loginchecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? isLoggedIn = prefs.getInt('loggedin');
    print("isLoggedIn=$isLoggedIn");
  }
}
