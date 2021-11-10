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
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Container(
        height: 48,
        padding: const EdgeInsets.all(15),
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.black, width: 1),borderRadius: BorderRadius.circular(15)
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
              //color: Colors.black,
            ),
            //const SizedBox(width: 5),
            // Text('Request Placed On : ',
            //     style: GoogleFonts.poppins(color: Colors.black)),
            Text(
                DateFormat('dd MMM yyyy, hh:mm')
                    .format((widget.request.time).toDate()),
                style: GoogleFonts.poppins(color: Colors.black)),
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50.0),
                color: widget.request.status == "accepted"
                    ? Colors.lightGreen
                    : widget.request.status == "rejected"
                        ? Colors.redAccent
                        : widget.request.status == "processing"
                            ? Colors.lightBlue
                            : widget.request.status == "requested"
                                ? Colors.black54
                                : Colors.deepPurple,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.request.status,
                      style: GoogleFonts.poppins(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
