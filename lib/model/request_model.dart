import 'package:cloud_firestore/cloud_firestore.dart';

class Requests {
  Requests({
    required this.status,
    required this.time,
    required this.userId,
    required this.type,
  });
  String status;
  Timestamp time;
  String userId;
  String type;

  factory Requests.fromDoc(Map json) => Requests(
        status: json["status"],
        time: json["time"],
        userId: json["userId"],
        type: json['type']
      );

  Map toJson() => {
        "transactionStatus": status,
        "time": time,
        "userId": userId,
        "type" : type
      };
}
