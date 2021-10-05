import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Workspace {
    String spaceId;
    String name;
    String address;
    String description;
    String photoUrl;
    Map time;
    String ownerId;
    Timestamp lastUpdated;
    String addedBy;

    Workspace({
        required this.spaceId,
       required this.name,
       required this.address,
       required this.description,
       required this.photoUrl,
       required this.time,
       required this.ownerId,
       required this.lastUpdated,
       required this.addedBy,
    });

    

    factory Workspace.fromDoc(Map<String, dynamic> json) => Workspace(
        spaceId: json["spaceId"],
        name: json["name"],
        address: json["address"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        time: json["time"],
        ownerId: json["ownerId"],
        lastUpdated: json["lastUpdated"],
        addedBy: json["addedBy"],
    );

    Map<String, dynamic> toJson() => {
        "spaceId": spaceId,
        "name": name,
        "address": address,
        "description": description,
        "photoUrl": photoUrl,
        "time": time,
        "ownerId": ownerId,
        "lastUpdated": lastUpdated,
        "addedBy": addedBy,
    };
}
