import 'package:cloud_firestore/cloud_firestore.dart';

class Bookings {
  String bookId;
  String userId;
  String spaceId;
  bool isSingleDay;
  Timestamp fromDate;
  Timestamp toDate;
  String status;
  String transactionId;
  Timestamp timeStamp;

  Bookings({
    required this.bookId,
    required this.userId,
    required this.spaceId,
    required this.isSingleDay,
    required this.fromDate,
    required this.toDate,
    required this.status,
    required this.transactionId,
    required this.timeStamp,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
      bookId: json["bookId"],
      userId: json["userId"],
      spaceId: json["spaceId"],
      isSingleDay: json["isSingleDay"],
      fromDate: json["fromDate"],
      toDate: json["toDate"],
      status: json["status"],
      transactionId: json["transactionId"],
      timeStamp: json['timeStamp']);

  Map<String, dynamic> toJson() => {
        "bookId": bookId,
        "userId": userId,
        "spaceId": spaceId,
        "isSingleDay": isSingleDay,
        "fromDate": fromDate,
        "toDate": toDate,
        "status": status,
        "transactionId": transactionId,
        'timeStamp': timeStamp
      };
}
