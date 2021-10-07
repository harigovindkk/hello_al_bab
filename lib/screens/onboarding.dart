import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/login.dart';
import 'package:hello_al_bab/services/authentication.dart';

final List<String> imagesList = [
  'https://images.pexels.com/photos/927022/pexels-photo-927022.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  'https://images.pexels.com/photos/3178818/pexels-photo-3178818.jpeg',
  'https://cdn.pixabay.com/photo/2019/01/14/17/25/gelato-3932596_1280.jpg',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Colors.black, primary],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
              stops: [0.1, 0.9],
              tileMode: TileMode.mirror),
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
                                  image: NetworkImage(item),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MediaQuery.of(context).size.width * 0.5)),
                                border: Border.all(
                                  color: primary,
                                  width: 2.5,
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
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              details[imagesList.indexOf(item)],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
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
                          ? const Color(0xffE8BD71)
                          : const Color(0xffC4C4C4),
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

              Spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      primary: primary,
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: () {
                     // AuthenticationHelper().signOut();
                       Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
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