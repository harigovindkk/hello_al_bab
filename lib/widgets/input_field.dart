import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/constants/colors.dart';

class InputField extends StatefulWidget {
  final String labeltext;
  final TextEditingController myController;
  //const InputField({ Key? key }) : super(key: key);
  InputField(this.labeltext, this.myController);
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String labeltext='Hai';
    return TextFormField(
      style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600),
      cursorColor: Colors.black,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return "This field can't be empty";
        }
        return null;
      },
      controller: widget.myController,
      decoration: InputDecoration(
        labelText: widget.labeltext,
        labelStyle: GoogleFonts.poppins(color: const Color(0xff181818)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
            bottomLeft: Radius.circular(4.0),
            bottomRight: Radius.circular(4.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color:  Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
            bottomLeft: Radius.circular(4.0),
            bottomRight: Radius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
