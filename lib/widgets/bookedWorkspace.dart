import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BookedWorkSpaceCard extends StatefulWidget {
  @override
  _BookedWorkSpaceCardState createState() => _BookedWorkSpaceCardState();
}

class _BookedWorkSpaceCardState extends State<BookedWorkSpaceCard> {
  bool liked = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 70),
      // height:MediaQuery.of(context).size.height*0.3 ,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.all(25),

            width: MediaQuery.of(context).size.width * 0.25,
            // height: MediaQuery.of(context).size.width * 0.35,
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://www.oyorooms.com/blog/wp-content/uploads/2018/03/fe-32-1024x683.jpg',
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 30,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: boxColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      " Wellington Place",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: primary),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fames praesent porttitor eu.",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 11),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Space",
                                    style: GoogleFonts.poppins(color: primary))
                              ],
                            ),
                            Column(
                              children: [
                                Text("Coworking",
                                    style: GoogleFonts.poppins(color: primary))
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Date",
                                    style: GoogleFonts.poppins(color: primary))
                              ],
                            ),
                            Column(
                              children: [
                                Text("29.09.2021-9.10.21",
                                    style: GoogleFonts.poppins(color: primary))
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Time",
                                    style: GoogleFonts.poppins(color: primary))
                              ],
                            ),
                            Column(
                              children: [
                                Text("12.30PM - 5.30PM",
                                    style: GoogleFonts.poppins(color: primary))
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Guests",
                                    style: GoogleFonts.poppins(color: primary))
                              ],
                            ),
                            Column(
                              children: [
                                Text("3",
                                    style: GoogleFonts.poppins(color: primary))
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
