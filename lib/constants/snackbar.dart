import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

final snackbar = SnackBar(
  backgroundColor: Colors.transparent,
  elevation: 50.0,
  content: Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: lightprimary,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //replace the icon below while copying
        const Icon(Icons.warning_amber_rounded, color: Colors.black),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          //replace text with custom message
          child: Text('Message',
              style: GoogleFonts.poppins(color: Colors.black)),
        ),
      ],
    ),
  ),
);


//paste this to create snackbar using this variable

 //ScaffoldMessenger.of(context).showSnackBar(snackBar);