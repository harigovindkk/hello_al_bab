import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/model/request_model.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkSpaceRequestCard extends StatefulWidget {
  // const WorkSpaceRequestCard({ Key? key }) : super(key: key);
  Requests request;
  WorkSpaceRequestCard(this.request);
  @override
  _WorkSpaceRequestCardState createState() => _WorkSpaceRequestCardState();
}

class _WorkSpaceRequestCardState extends State<WorkSpaceRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: primary, width: 1),borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Request Placed On : ',
                        style: GoogleFonts.poppins(color: primary)),
                    Text(
                        DateFormat('dd-MM-yyyy hh:mm')
                            .format((widget.request.time).toDate()),
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Request Status : ',
                        style: GoogleFonts.poppins(color: primary)),
                    Text(widget.request.status,
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ],
                ),
              ],
            ),
            Icon(
                  widget.request.status == "accepted"
                  ? Icons.check
                  : widget.request.status == "rejected"
                      ? Icons.close
                      : widget.request.status == "processing"
                          ? Icons.hourglass_bottom
                          : widget.request.status == "requested"
                              ? Icons.add_task_outlined
                              : Icons.error,
                              color: primary,
                              size: 45,
            )
            // Image.asset(
            //   widget.request.status == "accepted"
            //       ? 'images/success.JPG'
            //       : widget.request.status == "rejected"
            //           ? 'images/failed.png'
            //           : widget.request.status == "processing"
            //               ? 'images/processing.png'
            //               : widget.request.status == "requested"
            //                   ? 'images/requested.png'
            //                   : '',
            //   fit: BoxFit.fill,
            //   height: MediaQuery.of(context).size.width * 0.5,
            // ),
          ],
        ),
      ),
    );
  }
}
