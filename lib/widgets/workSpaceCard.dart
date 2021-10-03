import 'package:flutter/material.dart';

class WorkSpaceCard extends StatefulWidget {
  @override
  _WorkSpaceCardState createState() => _WorkSpaceCardState();
}

class _WorkSpaceCardState extends State<WorkSpaceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom:10),
      // height:MediaQuery.of(context).size.height*0.3 ,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            
            width: MediaQuery.of(context).size.width * 0.35,
            // height: MediaQuery.of(context).size.width * 0.35,
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://www.oyorooms.com/blog/wp-content/uploads/2018/03/fe-32-1024x683.jpg',
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.width * 0.35,
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
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
                      " Weelington Place",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Organising a conference might not seem so much of challenging .",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "0.8 kilometers",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.deepPurple),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 40,
            top: 15,
            width: 40,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.deepPurple,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
