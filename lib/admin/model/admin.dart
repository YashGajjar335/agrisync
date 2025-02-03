import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String adminId;
  final String name;
  final String role;
  final String email;

  Admin(
      {required this.adminId,
      required this.name,
      required this.role,
      required this.email});

  Map<String, dynamic> toJson() =>
      {"adminId": adminId, "name": name, "role": role, "email": email};

  static Admin fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>?;
    return Admin(
      adminId: snapshot?["adminId"] ?? "",
      name: snapshot?["name"] ?? "",
      role: snapshot?["role"] ?? "",
      email: snapshot?["email"] ?? "",
    );
  }
}
