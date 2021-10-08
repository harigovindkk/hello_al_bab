class Wishlist {
  Wishlist({
    required this.uid,
    required this.spaceId,
  });

  String uid;
  String spaceId;

  factory Wishlist.fromMap(Map<String, dynamic> json) => Wishlist(
        uid: json["uid"],
        spaceId: json["spaceId"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "spaceId": spaceId,
      };
}
