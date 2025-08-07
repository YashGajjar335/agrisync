import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class CropHealthReminder {
  final String chrId;
  final String uid;
  final String cropId;
  final DateTime startDate;
  final DateTime endingDate;

  CropHealthReminder({
    required this.chrId,
    required this.uid,
    required this.cropId,
    required this.startDate,
    required this.endingDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "chrId": chrId,
      "uid": uid,
      "cropId": cropId,
      "startDate": startDate,
      "endingDate": endingDate,
    };
  }

  static CropHealthReminder fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CropHealthReminder(
      chrId: snapshot['chrId'] ?? "",
      uid: snapshot['uid'] ?? "",
      cropId: snapshot['cropId'] ?? "",
      startDate: (snapshot['startDate'] as Timestamp).toDate(),
      endingDate: (snapshot['endingDate'] as Timestamp).toDate(),
    );
  }
}
