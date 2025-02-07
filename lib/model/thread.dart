import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/agri_connect_services.dart';

class Thread {
  final String threadId;
  final String uid;
  final String photoUrl;
  final String description;
  final List<String> like;
  final DateTime uploadAt;
  final List<String> save;
  final bool isLiked;
  final bool isSaved;
  final int totalLike;
  String? userProfilePic;
  String? userName;

  Thread({
    required this.threadId,
    required this.uid,
    required this.photoUrl,
    required this.description,
    required this.like,
    required this.uploadAt,
    required this.save,
    this.isLiked = false,
    this.isSaved = false,
    this.totalLike = 0,
  });

  Map<String, dynamic> toJson() => {
        "threadId": threadId,
        "uid": uid,
        "photoUrl": photoUrl,
        "description": description,
        "like": like,
        "uploadAt": uploadAt,
        "save": save,
      };

  static Thread fromSnap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    final likes = List<String>.from(map['like'] ?? []);
    final saved = List<String>.from(map['save'] ?? []);
    final isLiked = likes.contains(AgriConnectService.instance.uid);
    final isSaved = saved.contains(AgriConnectService.instance.uid);
    final totalLike = likes.length;
    return Thread(
      threadId: map['threadId'] ?? "",
      uid: map['uid'] ?? "",
      photoUrl: map['photoUrl'] ?? "",
      description: map['description'] ?? "",
      like: likes,
      uploadAt: (map['uploadAt'] as Timestamp).toDate() ?? DateTime.now(),
      save: List<String>.from(map['save'] ?? []),
      isLiked: isLiked,
      isSaved: isSaved,
      totalLike: totalLike,
    );
  }
}
