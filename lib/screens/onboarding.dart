import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_al_bab/services/authentication.dart';

final List<String> imagesList = [
  'images/search.jpg',
  'images/book.jpg',
  'images/workspace.jpg',
];

final List<String> titles = [
  ' Search ',
  ' Book ',
  ' Go ',
];
final List<String> details = [
  'Effortlessly filter and compare 3300 workspaces based on location, type and amenities.',
  'Pay for the space you need, as long as you need, and nothing more',
  'Get useful directions to your workspace - it’ll be ready from the moment you arrive'
];

class OnBoardingScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

  void setFirstTime() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('isFirstTime', 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
         color: Colors.white
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 420,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  //scrollDirection: Axis.vertical,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        _currentIndex = index;
                      },
                    );
                  },
                ),
                items: imagesList
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: lightprimary,
                                image: DecorationImage(
                                  image: AssetImage(item),
                                  fit: BoxFit.cover,
                                ),
                                
                              ),
                            ),
                            // CircleAvatar(radius: 100.0,foregroundColor: lightprimary,
                            //   foregroundImage: NetworkImage(item),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(titles[imagesList.indexOf(item)],
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              details[imagesList.indexOf(item)],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),

                        //  Card(
                        //   margin: const EdgeInsets.only(
                        //     top: 10.0,
                        //     bottom: 10.0,
                        //   ),
                        //   elevation: 6.0,
                        //   shadowColor: Colors.grey,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(100.0),
                        //   ),
                        //   child: ClipRRect(
                        //     borderRadius: const BorderRadius.all(
                        //       Radius.circular(100.0),
                        //     ),
                        //     child:
                        // Image.network(
                        //       item,
                        //       fit: BoxFit.cover,
                        //       width: double.infinity,
                        //     ),
                        //   ),
                        // ),

                        // Card(
                        //   margin: const EdgeInsets.only(
                        //     top: 10.0,
                        //     bottom: 10.0,
                        //   ),
                        //   elevation: 6.0,
                        //   shadowColor: Colors.grey,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(100.0),
                        //   ),
                        //   child: CircleAvatar(radius: 100.0,
                        //       foregroundImage: NetworkImage(item),
                        //     ),
                        // ),
                      ),
                    )
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imagesList.map((urlOfItem) {
                  int index = imagesList.indexOf(urlOfItem);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ?  Colors.black
                          : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
              //Spacer(),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.8,
              //     margin: EdgeInsets.all(10),
              //     child: ElevatedButton(
              //         style: ButtonStyle(
              //             shape:
              //                 MaterialStateProperty.all<RoundedRectangleBorder>(
              //                     RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(18.0),
              //         ))),
              //         onPressed: () {},
              //         child: Text(
              //           "Register",
              //           style: GoogleFonts.poppins(),
              //         ))),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50.0),
                  gradient: const LinearGradient(
                      colors: <Color>[Color(0xffF9DB39), Color(0xffFFEF62)],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.1, 0.4],
                      tileMode: TileMode.mirror),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    elevation: 0,
                    primary: Colors.transparent,
                    padding: const EdgeInsets.all(15),
                  ),
                    onPressed: () {
                      setFirstTime();
                      // AuthenticationHelper().signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.8,
              //   margin: EdgeInsets.all(10),
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //         backgroundColor: MaterialStateProperty.all(Colors.white),
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(18.0),
              //         ))),
              //     onPressed: () {},
              //     child: Text(
              //       "Login",
              //       style: GoogleFonts.poppins(color: Colors.black),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
