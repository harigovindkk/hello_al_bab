// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:hello_al_bab/constants/colors.dart';

class WorkSpaceDetail extends StatefulWidget {
  const WorkSpaceDetail({Key? key}) : super(key: key);

  @override
  _WorkSpaceDetailState createState() => _WorkSpaceDetailState();
}

class _WorkSpaceDetailState extends State<WorkSpaceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Image.network(
              'https://picsum.photos/seed/118/600',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(20, 1.5),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.only(top :15.0, left: 20, right: 20 ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Workspace Name',
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold, color: primary),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...',
                        style: GoogleFonts.poppins(color: Colors.white38),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ExpandableText(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        expandText: 'See More',
                        collapseText: 'See Less',
                        maxLines: 5,
                        style: GoogleFonts.poppins(color: Colors.white),
                        linkColor: primary,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Opening Timings',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold, color: primary),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Monday', style: GoogleFonts.poppins(color: Colors.white),),
                               Text('8.30 -17.30',style: GoogleFonts.poppins(color: Colors.white),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tuesday',style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              Text('8.30 -17.30',style: GoogleFonts.poppins(color: Colors.white),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Wednesday',style: GoogleFonts.poppins(color: Colors.white),),
                              Text('8.30 -17.30',style: GoogleFonts.poppins(color: Colors.white),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Thursday',style: GoogleFonts.poppins(color: Colors.white),),
                              Text('8.30 -17.30',style: GoogleFonts.poppins(color: Colors.white),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Friday',style: GoogleFonts.poppins(color: Colors.white),),
                              Text('8.30 -17.30',style: GoogleFonts.poppins(color: Colors.white),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Saturday',style: GoogleFonts.poppins(color: Colors.white),),
                              Text('8.30 -17.30',style: GoogleFonts.poppins(color: Colors.white),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sunday',style: GoogleFonts.poppins(color: Colors.white),),
                              Text('8.30 -17.30',style: GoogleFonts.poppins(color: Colors.white),),
                            ],
                          ),
                        ],
                      ),
                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:MaterialStateProperty.all( primary),
                                    foregroundColor: MaterialStateProperty.all(Colors.black),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))),
                                  onPressed: () {},
                                  child: Text(
                                    "Book Now",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
