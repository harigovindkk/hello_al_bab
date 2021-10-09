import 'package:flutter/material.dart';
import 'package:hello_al_bab/provider.dart';
import 'package:hello_al_bab/screens/home.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:hello_al_bab/screens/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello_al_bab/screens/signup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Al Bab',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? isLoggedin = null;
  loginChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedin = prefs.getInt('loggedin');
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HelloAlbabProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isLoggedin == 0 ? LoginPage() : Home(),
      ),
    );
  }
}
