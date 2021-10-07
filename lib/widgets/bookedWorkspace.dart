import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:hello_al_bab/model/bookings_model.dart';
import 'package:hello_al_bab/model/workspace_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookedWorkSpaceCard extends StatefulWidget {
  Bookings? bookingDetail;
  BookedWorkSpaceCard(this.bookingDetail);
  @override
  _BookedWorkSpaceCardState createState() => _BookedWorkSpaceCardState();
}

class _BookedWorkSpaceCardState extends State<BookedWorkSpaceCard> {
  Workspace? workspace;
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

  bool liked = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    getDetails().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: primary,
            ),
          )
        : Container(
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
                            workspace!.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: primary),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            workspace!.address,
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 11),
                          ),
                          SizedBox(
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
                                              color: primary))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Coworking",
                                          style: GoogleFonts.poppins(
                                              color: primary))
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
                                      Text("Date",
                                          style: GoogleFonts.poppins(
                                              color: primary))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          widget.bookingDetail!.isSingleDay
                                              ? DateFormat('dd/MM/yyyy').format(
                                                  widget.bookingDetail!.fromDate
                                                      .toDate())
                                              : '${DateFormat('dd/MM/yyyy').format(widget.bookingDetail!.fromDate.toDate())}-${DateFormat('dd/MM/yyyy').format(widget.bookingDetail!.toDate.toDate())}',
                                          style: GoogleFonts.poppins(
                                              color: primary))
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
                                      Text("Time",
                                          style: GoogleFonts.poppins(
                                              color: primary))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          "${DateFormat('hh:mm').format(widget.bookingDetail!.fromDate.toDate())} - ${DateFormat('hh:mm').format(widget.bookingDetail!.toDate.toDate())}",
                                          style: GoogleFonts.poppins(
                                              color: primary))
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
                                      Text("Guests",
                                          style: GoogleFonts.poppins(
                                              color: primary))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("3",
                                          style: GoogleFonts.poppins(
                                              color: primary))
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
