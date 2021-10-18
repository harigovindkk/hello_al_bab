import 'package:flutter/material.dart';
import 'package:hello_al_bab/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_al_bab/model/workspace_model.dart';
import 'package:hello_al_bab/screens/locationAvailable.dart';
import 'package:hello_al_bab/screens/workspace_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkSpaceCard extends StatefulWidget {
  // final Workspace workspace;
  final String? spaceId;

  const WorkSpaceCard({Key? key, required this.spaceId}) : super(key: key);
  @override
  _WorkSpaceCardState createState() => _WorkSpaceCardState();
}

class _WorkSpaceCardState extends State<WorkSpaceCard> {
  Workspace? workspace;
  bool isLoading = true;
  bool? liked = false;

  // Future<void> getDetails() async {
  //   return FirebaseFirestore.instance
  //       .collection('favourites')
  //       .where({'spaceId',})
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       liked = false;
  //       //workspaceData= value;
  //     });
  //     print(workspace!.addedBy);
  //   });
  // }

  Future<void> getDetails() async {
    return FirebaseFirestore.instance
        .collection('workspace')
        .doc(widget.spaceId)
        .get()
        .then((value) {
      setState(() {
        workspace = Workspace.fromDoc(value.data() as Map<String, dynamic>);
        //workspaceData= value;
      });
    });
  }

  Future<void> likeChecker() async {
    return FirebaseFirestore.instance
        .collection('wishlist')
        .doc(FirebaseAuth.instance.currentUser!.uid + '_' + workspace!.spaceId)
        .get()
        .then((value) {
      setState(() {
        if (value.exists) {
          setState(() {
            liked = true;
          });
        }
        //workspaceData= value;
      });
      // print(workspace!.addedBy);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getDetails().whenComplete(() {
      setState(() {
        isLoading = false;
      });
      likeChecker();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 10),
      // height:MediaQuery.of(context).size.height*0.3 ,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LocationAvailable(
                      workspace: workspace!,
                    )),
          );
        },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primary,
                ),
              )
            : Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    margin: const EdgeInsets.all(25),

                    width: MediaQuery.of(context).size.width * 0.3,
                    // height: MediaQuery.of(context).size.width * 0.35,
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        workspace!.photoUrl,
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
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: boxColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              workspace!.name,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: primary),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              workspace!.address,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
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
                          const BoxShadow(
                            color: Colors.black,
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          liked!
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_outlined,
                          color: primary,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            liked = !liked!;
                          });
                          if (liked!) {
                            //item added to wishlist
                            print("liked");
                            FirebaseFirestore.instance
                                .collection('wishlist')
                                .doc(FirebaseAuth.instance.currentUser!.uid +
                                    '_' +
                                    workspace!.spaceId)
                                .set(
                              {
                                'ownerId': workspace!.ownerId,
                                'userId':
                                    FirebaseAuth.instance.currentUser!.uid,
                                'spaceId': workspace!.spaceId,
                                'photoUrl': workspace!.photoUrl,
                                'name': workspace!.name,
                                'address': workspace!.address,
                                'timeStamp': Timestamp.now(),
                              },
                              SetOptions(
                                merge: true,
                              ),
                            );
                          } else {
                            //item removed from wishlist
                            FirebaseFirestore.instance
                                .collection('wishlist')
                                .doc(FirebaseAuth.instance.currentUser!.uid +
                                    '_' +
                                    workspace!.spaceId)
                                .delete();
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
