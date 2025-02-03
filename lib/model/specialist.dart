import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Specialist {
  final String uid;
  final String uname;
  final String role;
  final String profilePic;
  final String validProof;
  final String email;
  // final String password;
  final bool isVerified;

  Specialist({
    required this.uid,
    required this.role,
    required this.profilePic,
    required this.isVerified,
    required this.uname,
    required this.email,
    // required this.password,
    required this.validProof,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uname": uname.trim(),
        "email": email.trim(),
        // "password": password.trim(),
        "isVerified": isVerified,
        "profilePic": profilePic,
        "validProof": validProof,
        "role": role,
      };

  factory Specialist.fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return Specialist(
      uname: snapshot["uname"] ?? "",
      email: snapshot["email"] ?? "",
      // password: snapshot["password"] ?? "",
      validProof: snapshot["validProof"] ?? "",
      uid: snapshot["uid"] ?? "",
      role: snapshot["role"] ?? "",
      profilePic: snapshot["profilePic"] ?? "",
      isVerified: snapshot["isVerified"] ?? false,
    );
  }
}
