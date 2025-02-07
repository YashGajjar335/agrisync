import 'package:cloud_firestore/cloud_firestore.dart';

class Specialist {
  final String uid;
  final String uname;
  final String role;
  final String profilePic;
  final String validProof;
  final String email;
  final bool isVerified;
  final List<String> following;
  final List<String> followers;
  // final String password;

  Specialist({
    required this.uid,
    required this.role,
    required this.profilePic,
    required this.isVerified,
    required this.uname,
    required this.email,
    required this.validProof,
    required this.following,
    required this.followers,
    // required this.password,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uname": uname.trim(),
        "email": email.trim(),
        "isVerified": isVerified,
        "profilePic": profilePic,
        "validProof": validProof,
        "role": role,
        "following": following,
        "followers": followers,
        // "password": password.trim(),
      };

  factory Specialist.fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return Specialist(
      uname: snapshot["uname"] ?? "",
      email: snapshot["email"] ?? "",
      validProof: snapshot["validProof"] ?? "",
      uid: snapshot["uid"] ?? "",
      role: snapshot["role"] ?? "",
      profilePic: snapshot["profilePic"] ?? "",
      isVerified: snapshot["isVerified"] ?? false,
      following: List<String>.from(snapshot['following'] ?? []),
      followers: List<String>.from(snapshot['followers'] ?? []),
      // password: snapshot["password"] ?? "",
    );
  }

  factory Specialist.fromMap(Map<String, dynamic> map) {
    return Specialist(
      uname: map["uname"] ?? "",
      email: map["email"] ?? "",
      validProof: map["validProof"] ?? "",
      uid: map["uid"] ?? "",
      role: map["role"] ?? "",
      profilePic: map["profilePic"] ?? "",
      isVerified: map["isVerified"] ?? false,
      following: List<String>.from(map['following'] ?? []),
      followers: List<String>.from(map['followers'] ?? []),
      // password: snapshot["password"] ?? "",
    );
  }
}
