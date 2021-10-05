import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/screens/workspace_detail.dart';

class WorkSpaceCard extends StatefulWidget {
  @override
  _WorkSpaceCardState createState() => _WorkSpaceCardState();
}

class _WorkSpaceCardState extends State<WorkSpaceCard> {
  bool liked = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 10),
      // height:MediaQuery.of(context).size.height*0.3 ,
      child: InkWell(
        onTap: (){
          Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkSpaceDetail()),
                    );
        },
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              margin: EdgeInsets.all(25),
      
              width: MediaQuery.of(context).size.width * 0.3,
              // height: MediaQuery.of(context).size.width * 0.35,
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'https://www.oyorooms.com/blog/wp-content/uploads/2018/03/fe-32-1024x683.jpg',
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 30,
              width: MediaQuery.of(context).size.width * 0.65,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: boxColor,
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
                        " Wellington Place",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: primary),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fames praesent porttitor eu.",
                        style: GoogleFonts.poppins(color: Colors.white,fontSize: 12),
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
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: boxColor),
                  color: boxColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                      blurRadius: 5.0,
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
                    liked
                        ? Icons.favorite_outline_rounded
                        : Icons.favorite_rounded,
                    color: primary,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      liked = !liked;
                    });
                    if(liked){
                      //item added to wishlist
                    }else{
                      //item removed from wishlist
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
