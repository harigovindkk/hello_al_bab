import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:hello_al_bab/screens/search_result.dart';
import 'package:hello_al_bab/screens/locationAvailable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchCriteria extends StatefulWidget {
  @override
  _SearchCriteriaState createState() => _SearchCriteriaState();
}

class _SearchCriteriaState extends State<SearchCriteria> {
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  String? _selectedFromTime;
  String? _selectedToTime;
  int guests = 0;
  bool singleDay = false;
  bool isSingleDay = false;
  bool isMultipleDay = false;
  String type = '';
  String spec = '';

  _getOfficeCriteria() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getString('type').toString();
      spec = prefs.getString('spec').toString();
    });
    print("type = " + type + ", spec = " + spec);
  }

  Future<void> _showFromTime() async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: "Select from time",
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              primaryColor: primary,
              accentColor: lightprimary,
              colorScheme: const ColorScheme.dark(
                primary: primary,
                onPrimary: lightprimary,
                // surface: primary,
                onSurface: Colors.white,
              ),
            ),
            child: child!,
          );
        });
    if (result != null) {
      setState(() {
        _selectedFromTime = result.format(context);
      });
    }
  }

  Future<void> _showToTime() async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: "Select to time",
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              primaryColor: primary,
              accentColor: lightprimary,
              colorScheme: ColorScheme.dark(
                primary: primary,
                onPrimary: lightprimary,
                // surface: primary,
                onSurface: Colors.white,
              ),
            ),
            child: child!,
          );
        });
    if (result != null) {
      setState(() {
        _selectedToTime = result.format(context);
      });
    }
  }

  _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      helpText: 'Select from date',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: primary,
            accentColor: lightprimary,
            colorScheme: ColorScheme.dark(
              primary: primary,
              onPrimary: lightprimary,
              surface: primary,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedFromDate)
      setState(() {
        selectedFromDate = picked;
      });
  }

  _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      helpText: 'Select to date',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: primary,
            accentColor: lightprimary,
            colorScheme: const ColorScheme.dark(
              primary: primary,
              onPrimary: lightprimary,
              surface: primary,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedToDate) {
      setState(() {
        selectedToDate = picked;
      });
    }
  }

  @override
  void initState() {
    print(123);
    _getOfficeCriteria();
    // print("type = " + type + ", spec = " + spec);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Search Criteria",
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, color: primary),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Row(
            //   children: [
            //     Text("Space type",
            //         style:
            //             GoogleFonts.poppins(color: Colors.white))
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ElevatedButton(
            //         child: new Text(
            //           'Coworking',
            //           style: GoogleFonts.poppins(color: primary),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           primary: Colors.black,
            //           shape: (RoundedRectangleBorder(
            //             side: BorderSide(
            //               color: primary,
            //             ),
            //             borderRadius: BorderRadius.circular(5.0),
            //           )),
            //         ),
            //         onPressed: () {},
            //       ),
            //     ),
            //     SizedBox(width: 5),
            //     Expanded(
            //       child: ElevatedButton(
            //         child: new Text(
            //           'Meeting',
            //           style: GoogleFonts.poppins(color: primary),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           primary: Colors.black,
            //           shape: (RoundedRectangleBorder(
            //             side: BorderSide(
            //               color: primary,
            //             ),
            //             borderRadius: BorderRadius.circular(5.0),
            //           )),
            //         ),
            //         onPressed: () {},
            //       ),
            //     ),
            //     SizedBox(width: 5),
            //     Expanded(
            //       child: ElevatedButton(
            //         child: new Text(
            //           'Office',
            //           style: GoogleFonts.poppins(color: primary),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           primary: Colors.black,
            //           shape: (RoundedRectangleBorder(
            //             side: BorderSide(
            //               color: primary,
            //             ),
            //             borderRadius: BorderRadius.circular(5.0),
            //           )),
            //         ),
            //         onPressed: () {},
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                Text("Date", style: GoogleFonts.poppins(color: Colors.white))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: new Text(
                      'Single Day',
                      style: GoogleFonts.poppins(
                          color: isSingleDay ? Colors.black : primary),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: isSingleDay ? primary : Colors.black,
                      shape: (RoundedRectangleBorder(
                        side: const BorderSide(
                          color: primary,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                    ),
                    onPressed: () {
                      setState(() {
                        isSingleDay = !isSingleDay;
                      });
                      if (isSingleDay) {
                        isMultipleDay = false;
                      }
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    child: new Text(
                      'Multiple Days',
                      style: GoogleFonts.poppins(
                          color: isMultipleDay ? Colors.black : primary),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: isMultipleDay ? primary : Colors.black,
                      shape: (RoundedRectangleBorder(
                        side: const BorderSide(
                          color: primary,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                    ),
                    onPressed: () {
                      setState(() {
                        isMultipleDay = !isMultipleDay;
                      });
                      if (isMultipleDay) {
                        isSingleDay = false;
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date from',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date to',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectFromDate(context),
                    child: new Text(
                      "${selectedFromDate.day} / ${selectedFromDate.month} / ${selectedFromDate.year}",
                      style: GoogleFonts.poppins(color: primary),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: (RoundedRectangleBorder(
                        side: const BorderSide(
                          color: primary,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectToDate(context),
                    child: new Text(
                      "${selectedToDate.day} / ${selectedToDate.month} / ${selectedToDate.year}",
                      style: GoogleFonts.poppins(color: primary),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: (RoundedRectangleBorder(
                        side: const BorderSide(
                          color: primary,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isSingleDay ? true : false,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time from',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time to',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isSingleDay ? true : false,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showFromTime(),
                      child: new Text(
                        _selectedFromTime == null
                            ? "Select from time"
                            : _selectedFromTime.toString(),
                        style: GoogleFonts.poppins(color: primary),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: (RoundedRectangleBorder(
                          side: const BorderSide(
                            color: primary,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showToTime(),
                      child: new Text(
                        _selectedToTime == null
                            ? "Select to time"
                            : _selectedToTime.toString(),
                        style: GoogleFonts.poppins(color: primary),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: (RoundedRectangleBorder(
                          side: const BorderSide(
                            color: primary,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     Text("Number of guests",
            //         style:
            //             GoogleFonts.poppins( color: Colors.white))
            //   ],
            // ),
            // SizedBox(height: 5),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         padding: EdgeInsets.only(left: 8),
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //               color: primary, // red as border color
            //             ),
            //             borderRadius: BorderRadius.circular(5)),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               "Guests",
            //               style: GoogleFonts.poppins(color: primary),
            //             ),
            //             Row(
            //               children: [
            //                 IconButton(
            //                   padding: EdgeInsets.all(0),
            //                   onPressed: () {
            //                     setState(() {
            //                       guests--;
            //                     });
            //                   },
            //                   icon: Icon(
            //                     Icons.remove,
            //                     color: primary,
            //                     size: 15,
            //                   ),
            //                 ),
            //                 Container(
            //                   color: primary,
            //                   child: guests < 0 ? Text("0") : Text("$guests"),
            //                   padding: EdgeInsets.all(16),
            //                 ),
            //                 IconButton(
            //                   onPressed: () {
            //                     setState(() {
            //                       guests++;
            //                     });
            //                   },
            //                   icon: Icon(
            //                     Icons.add,
            //                     color: primary,
            //                     size: 15,
            //                   ),
            //                 ),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primary,
                    padding: const EdgeInsets.all(10),
                    shape: (RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))),
                child: Text(
                  "Check Availability",
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('isSingle', isSingleDay);
                  if (isSingleDay) {
                    prefs.setString('fromDate', "${selectedFromDate}");
                    prefs.setString('toDate', "${selectedToDate}");
                    prefs.setString('fromTime', "${_selectedFromTime}");
                    prefs.setString('toTime', "${_selectedToTime}");
                  } else {
                    prefs.setString('fromDate', "${selectedFromDate}");
                    prefs.setString('toDate', "${selectedToDate}");
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchResults()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
