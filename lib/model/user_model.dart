class User {
  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.profilePicture,
    required this.createdTime,
  });

  String uid;
  String name;
  String email;
  String password;
  String phone;
  String profilePicture;
  DateTime createdTime;

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        profilePicture: json["profilePicture"],
        createdTime: json["createdTime"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "profilePicture": profilePicture,
        "createdTime": createdTime,
      };
}
