import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Bookings {
  String bookId;
  String userId;
  String spaceId;
  bool isSingleDay;
  Timestamp fromDate;
  Timestamp toDate;
  String? fromTime;
  String? toTime;
  String status;
  String transactionId;
  String type;
  String spec;
  Timestamp timeStamp;

  Bookings({
    required this.bookId,
    required this.userId,
    required this.spaceId,
    required this.isSingleDay,
    required this.fromDate,
    required this.toDate,
    this.fromTime,
    this.toTime,
    required this.spec,
    required this.type,
    required this.status,
    required this.transactionId,
    required this.timeStamp,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
      bookId: json["bookId"] ?? "",
      userId: json["userId"],
      spaceId: json["spaceId"],
      isSingleDay: json["isSingleDay"],
      fromDate: json["fromDate"],
      toDate: json["toDate"],
      toTime: json["toTime"] ?? "",
      fromTime: json["fromTime"] ?? "",
      status: json["status"],
      spec: json["spec"] ?? "",
      type: json["type"]??"",
      transactionId: json["transactionId"],
      timeStamp: json['timeStamp']);

  Map<String, dynamic> toJson(JsonCodec json) => {
        "bookId": bookId,
        "userId": userId,
        "spaceId": spaceId,
        "isSingleDay": isSingleDay,
        "fromDate": fromDate,
        "toDate": toDate,
        "toTime": toTime,
        "type": type,
        "spec": spec,
        "fromTime": fromTime,
        "status": status,
        "transactionId": transactionId,
        'timeStamp': timeStamp
      };
}
