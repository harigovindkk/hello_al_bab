import 'package:cloud_firestore/cloud_firestore.dart';

class Requests {
  Requests({
    required this.status,
    required this.time,
    required this.userId,
  });
  String status;
  Timestamp time;
  String userId;

  factory Requests.fromDoc(Map json) => Requests(
        status: json["status"],
        time: json["time"],
        userId: json["userId"],
      );

  Map toJson() => {
        "transactionStatus": status,
        "time": time,
        "userId": userId,
      };
}
