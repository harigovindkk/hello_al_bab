import 'package:flutter/material.dart';

const primary = Color(0xFFFFC700);
const lightprimary = Color(0xFFFBE9B7);
const boxColor = Color(0xFF292929);
const backgroundColor = Color(0xffE5E5E5);

BoxDecoration customDecoration = BoxDecoration(
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(50.0),
  gradient: const LinearGradient(
    colors: [
      Color(0xffFFC700),
      Color(0xffFFF50C),
      Color(0xffF9DB39),
      Color(0xffFFEF62),
      Color(0xffFFF50C),
    ],
  ),
  boxShadow: [
    BoxShadow(
      color: const Color(0xffFFC700).withOpacity(0.6),
      offset: const Offset(
        0,
        2,
      ),
      blurRadius: 4.0,
      spreadRadius: 2.0,
    ), //BoxShadow
    const BoxShadow(
      color: Color(0xffFCE07C),
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ), //BoxShadow
  ],
);

ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
  elevation: 0,
  primary: Colors.transparent,
  padding: const EdgeInsets.all(15),
);
