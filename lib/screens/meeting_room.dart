import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/conference_hall.dart';
import 'package:hello_al_bab/screens/searchCriteria.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeetingRoomPage extends StatefulWidget {
  const MeetingRoomPage({Key? key}) : super(key: key);

  @override
  _MeetingRoomPageState createState() => _MeetingRoomPageState();
}

class _MeetingRoomPageState extends State<MeetingRoomPage> {
  int guests = 0;
  bool isMoreThanTen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text('Meeting Room',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please specify the number of people',
                  style: GoogleFonts.poppins(color: Colors.black)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: primary, // red as border color
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Guests",
                          style: GoogleFonts.poppins(color: Colors.black),
                        ),
                        Row(
                          children: [
                            IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  guests--;
                                  if (guests > 10) {
                                    isMoreThanTen = true;
                                  } else {
                                    isMoreThanTen = false;
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: primary,
                                size: 15,
                              ),
                            ),
                            Container(
                              
                              child: guests < 0
                                  ? const Text("0")
                                  : Text("$guests"),
                              padding: const EdgeInsets.all(16),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  guests++;
                                  if (guests > 10) {
                                    isMoreThanTen = true;
                                  } else {
                                    isMoreThanTen = false;
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                color: primary,
                                size: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          isMoreThanTen
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Maximum number of people in a \n meeting room is 10',
                          style: GoogleFonts.poppins(color: Colors.black),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ConferenceHallPage()),
                            );
                          },
                          child: Text(
                            'Choose Conference Room ',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    )
                  ],
                )
              : const SizedBox(),
          const Spacer(),
         !isMoreThanTen? Padding(
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
                onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('spec', "${guests}");

                  if (!isMoreThanTen) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchCriteria()));
                  }
                },
                child: Text(
                  "Confirm",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ):SizedBox(),
        ],
      ),
    );
  }
}
