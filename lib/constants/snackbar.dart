import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar customSnackBar(String customMessage, IconData customIcon) {
  return SnackBar(
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
          Icon(customIcon, color: Colors.black),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(customMessage,maxLines: 3,overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(color: Colors.black)),
            ),
          ),
        ],
      ),
    ),
  );
}
