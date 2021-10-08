import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions {
  Transactions({
    required this.transactionId,
    required this.transactionStatus,
    required this.timeStamp,
    required this.modeOfPayment,
  });

  String transactionId;
  String transactionStatus;
  Timestamp timeStamp;
  String modeOfPayment;

  factory Transactions.fromDoc(Map<String, dynamic> json) => Transactions(
        transactionId: json["transactionId"],
        transactionStatus: json["transactionStatus"],
        timeStamp: json["timeStamp"],
        modeOfPayment: json["modeOfPayment"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "transactionStatus": transactionStatus,
        "timeStamp": timeStamp,
        "modeOfPayment": modeOfPayment,
      };
}
