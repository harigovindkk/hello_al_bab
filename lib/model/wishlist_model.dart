import 'package:cloud_firestore/cloud_firestore.dart';

class Wishlist {
  Wishlist(
      {required this.userId,
      required this.spaceId,
      required this.address,
      required this.name,
      required this.ownerId,
      required this.photoUrl,
      required this.timeStamp});

  String userId;
  String spaceId;
  String address, ownerId, photoUrl, name;
  Timestamp timeStamp;

  factory Wishlist.fromMap(Map<String, dynamic> json) => Wishlist(
        userId: json["userId"],
        spaceId: json["spaceId"],
        address: json["address"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        ownerId: json["ownerId"],
        timeStamp: json["timeStamp"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "spaceId": spaceId,
        'address': address,
        'name': name,
        'photoUrl': photoUrl,
        'ownerId': ownerId,
        'timeStamp': timeStamp
      };
}
