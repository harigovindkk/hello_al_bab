
import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/screens/searchCriteria.dart';
import 'package:intl/intl.dart';
import 'package:hello_al_bab/model/bookings_model.dart';
import 'package:hello_al_bab/model/workspace_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookedWorkSpaceCard extends StatefulWidget {
  final Bookings? bookingDetail;
  BookedWorkSpaceCard(this.bookingDetail);
  @override
  _BookedWorkSpaceCardState createState() => _BookedWorkSpaceCardState();
}

class _BookedWorkSpaceCardState extends State<BookedWorkSpaceCard> {
  Workspace? workspace;
  //String? fromTime, toTime;
  bool? isSingleDay = false;
  bool isLoading = true;
  DocumentSnapshot<Map<String, dynamic>>? workspaceData;
  Future<void> getDetails() async {
    return FirebaseFirestore.instance
        .collection('workspace')
        .doc(widget.bookingDetail!.spaceId)
        .get()
        .then((value) {
      setState(() {
        workspace = Workspace.fromDoc(value.data() as Map<String, dynamic>);
        //workspaceData= value;
      });
    });
  }

  // _getDayType() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     isSingleDate = prefs.getBool('isSingle');
  //     fromTime=prefs.getString('fromTime');
  //     toTime=prefs.getString('toTime');
  //   });
  //   print(isSingleDate);
  // }

  bool liked = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
   // _getDayType();
    getDetails().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
    print(
        DateFormat('dd/MM/yyyy').format(widget.bookingDetail!.toDate.toDate()));
    print(DateFormat('dd/MM/yyyy')
        .format(widget.bookingDetail!.fromDate.toDate()));
  }

  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: primary,
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 35),
            // height:MediaQuery.of(context).size.height*0.3 ,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  margin: const EdgeInsets.all(25),

                  width: MediaQuery.of(context).size.width * 0.25,
                   height: MediaQuery.of(context).size.width * 0.35,
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      workspace!.photoUrl,
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
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 7.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            workspace!.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            workspace!.address,
                            style: GoogleFonts.poppins(
                                color: Colors.black38, fontSize: 11),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("Space",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(widget.bookingDetail!.type,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black))
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        widget.bookingDetail!.isSingleDay == false
                                              ? "From Date"
                                              : "Date",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          DateFormat('dd/MM/yyyy').format(widget
                                              .bookingDetail!.fromDate
                                              .toDate()),
                                          // ${DateFormat('dd/MM/yyyy').format(widget.bookingDetail!.toDate.toDate())}
                                          style: GoogleFonts.poppins(
                                              color: Colors.black))
                                    ],
                                  )
                                ],
                              ),
                              widget.bookingDetail!.isSingleDay == false
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text("To Date",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                                DateFormat('dd/MM/yyyy').format(
                                                    widget.bookingDetail!.toDate
                                                        .toDate()),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black))
                                          ],
                                        )
                                      ],
                                    )
                                  : Container(),
                              widget.bookingDetail!.isSingleDay == true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Time",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                             "${widget.bookingDetail!.fromTime}-${widget.bookingDetail!.toTime}",
                                              //  "${DateFormat('hh:mm').format(widget.bookingDetail!.fromDate.toDate())} - ${DateFormat('hh:mm').format(widget.bookingDetail!.toDate.toDate())}",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black))
                                          ],
                                        )
                                      ],
                                    )
                                  : Container(),
                              widget.bookingDetail!.type == "Conference Hall"
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Purpose",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(widget.bookingDetail!.spec,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black))
                                          ],
                                        )
                                      ],
                                    )
                                  : widget.bookingDetail!.type == "Meeting Room"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text("Guests",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black))
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(widget.bookingDetail!.spec,
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black))
                                              ],
                                            )
                                          ],
                                        )
                                      : widget.bookingDetail!.type ==
                                              "Office Space"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("Area",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                        widget.bookingDetail!
                                                            .spec,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black))
                                                  ],
                                                )
                                              ],
                                            )
                                          : widget.bookingDetail!.type ==
                                                  "Coworking Space"
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                            "Companies",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .black))
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                            widget
                                                                .bookingDetail!
                                                                .spec,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .black))
                                                      ],
                                                    )
                                                  ],
                                                )
                                              : Row()
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                widget.bookingDetail!.status == "not booked"
                    ? Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Colors.white),
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                color: Colors.black12,
                                offset: Offset(
                                  0.0,
                                  0.0,
                                ),
                                blurRadius: 7.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchCriteria()),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: primary,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
  }
}
