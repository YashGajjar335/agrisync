import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String commentId;
  final String uid;
  final String comment;
  final List<String> like;
  Comment({
    required this.commentId,
    required this.comment,
    required this.like,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "comment": comment,
        "like": like,
        "uid": uid,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;
    return Comment(
      commentId: map["commentId"] ?? "",
      comment: map["comment"] ?? "",
      like: List<String>.from(map["like"] ?? []),
      uid: map["uid"] ?? "",
    );
  }
}
