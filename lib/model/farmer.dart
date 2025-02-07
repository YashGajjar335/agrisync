import 'package:cloud_firestore/cloud_firestore.dart';

class Farmer {
  final String uid;
  final String uname;
  final String role;
  final String profilePic;
  final String email;
  final List<String> following;
  final List<String> followers;
  // final String password;

  Farmer({
    required this.uid,
    required this.role,
    required this.profilePic,
    required this.uname,
    required this.email,
    required this.following,
    required this.followers,
    // required this.password,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uname": uname.trim(),
        "role": role,
        "profilePic": profilePic,
        "email": email,
        "following": following,
        "followers": followers,
        // "password": password,
      };

  static Farmer fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Farmer(
      uid: snapshot["uid"] ?? "",
      role: snapshot["role"] ?? "",
      profilePic: snapshot["profilePic"] ?? "",
      uname: snapshot["uname"] ?? "",
      email: snapshot["email"] ?? "",
      following: List<String>.from(snapshot['following'] ?? []),
      followers: List<String>.from(snapshot['followers'] ?? []),
      // password: snapshot["password"] ?? ""
    );
  }

  static Farmer fromMap(Map<String, dynamic> map) {
    return Farmer(
      uid: map["uid"] ?? "",
      role: map["role"] ?? "",
      profilePic: map["profilePic"] ?? "",
      uname: map["uname"] ?? "",
      email: map["email"] ?? "",
      following: List<String>.from(map['following'] ?? []),
      followers: List<String>.from(map['followers'] ?? []),
      // password: snapshot["password"] ?? ""
    );
  }
}
