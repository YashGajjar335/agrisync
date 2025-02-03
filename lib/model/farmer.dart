import 'package:cloud_firestore/cloud_firestore.dart';

class Farmer {
  final String uid;
  final String uname;
  final String role;
  final String profilePic;
  final String email;
  // final String password;

  Farmer({
    required this.uid,
    required this.role,
    required this.profilePic,
    required this.uname,
    required this.email,
    // required this.password,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "uname": uname.trim(),
        "role": role,
        "profilePic": profilePic,
        "email": email,
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
      // password: snapshot["password"] ?? ""
    );
  }
}
