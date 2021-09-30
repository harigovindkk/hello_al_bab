import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddListing extends StatefulWidget {
  const AddListing({Key? key}) : super(key: key);

  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {
  @override
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Center(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Request To Add Listing',
                    style: GoogleFonts.poppins(fontSize: 25),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        hintText: 'Enter your full name',
                        labelText: 'Name',
                        hintStyle: GoogleFonts.poppins(),
                        labelStyle: GoogleFonts.poppins()),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: const Icon(Icons.phone),
                        hintText: 'Enter a phone number',
                        labelText: 'Phone',
                        hintStyle: GoogleFonts.poppins(),
                        labelStyle: GoogleFonts.poppins()),
                    validator: (value) {
                      if (value!.isEmpty || value.length > 10) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        hintText: 'Enter your date of birth',
                        labelText: 'Dob',
                        hintStyle: GoogleFonts.poppins(),
                        labelStyle: GoogleFonts.poppins()),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter valid date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        primary: Colors.blueAccent,
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => GoogleSignIn()),
                        // );
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Data is in processing.')));
                        }
                      },
                      child: Text(
                        "Submit",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
