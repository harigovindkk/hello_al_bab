class Bookings {
  String bookId;
  String userId;
  String spaceId;
  String isSingleDay;
  String fromDate;
  String toDate;
  String status;
  String transactionId;

  Bookings({
    required this.bookId,
    required this.userId,
    required this.spaceId,
    required this.isSingleDay,
    required this.fromDate,
    required this.toDate,
    required this.status,
    required this.transactionId,
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
      );

  Map<String, dynamic> toJson() => {
        "bookId": bookId,
        "userId": userId,
        "spaceId": spaceId,
        "isSingleDay": isSingleDay,
        "fromDate": fromDate,
        "toDate": toDate,
        "status": status,
        "transactionId": transactionId,
      };
}
