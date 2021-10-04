class User {
  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.dob,
    required this.phone,
    required this.profilePicture,
    required this.createdTime,
  });

  String uid;
  String name;
  String email;
  DateTime dob;
  String phone;
  String profilePicture;
  DateTime createdTime;

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        dob: json["dob"],
        phone: json["phone"],
        profilePicture: json["profilePicture"],
        createdTime: json["createdTime"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "dob": dob,
        "phone": phone,
        "profilePicture": profilePicture,
        "createdTime": createdTime,
      };
}
