import 'package:flutter/material.dart';
import 'package:hello_al_bab/widgets/workSpaceCard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(123);
    FirebaseFirestore.instance
        .collection('users')
        .doc()
        .set(
          {
            'email': 'amjadpanjeeri@gmail.com',
          },
        )
        .whenComplete(() => print(123))
        .onError((error, stackTrace) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 20, bottom: 20),
                child: Text(
                  "Results",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Column(
            children: [
              // WorkSpaceCard(),
              WorkSpaceCard(),
              // SizedBox(height: 10,),
              WorkSpaceCard(),
            ],
          ),
          Spacer(),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                child: Text("Your Search Criteria"),
                onPressed: () {},
              ))
        ],
      ),
    );
  }
}
