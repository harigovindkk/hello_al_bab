import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  Users(
      {required this.uid,
      required this.name,
      required this.email,
      required this.dob,
      required this.phone,
      required this.profilePicture,
      required this.createdTime,
      required this.loginMethod});

  String uid;
  String name;
  String email;
  String dob;
  String phone;
  String profilePicture;
  Timestamp createdTime;
  String loginMethod;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        uid: json["uid"] ?? '',
        name: json["name"] ?? "",
        email: json["email"] ?? '',
        dob: json["dob"] ?? '',
        phone: json["phone"] ?? '',
        profilePicture: json["profilePicture"] ?? "",
        createdTime: json["createdTime"] ?? "",
        loginMethod: json["loginMethod"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "dob": dob,
        "phone": phone,
        "profilePicture": profilePicture,
        "createdTime": createdTime,
        "loginMethod": loginMethod,
      };
}
