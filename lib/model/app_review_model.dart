import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String uid;
  final String name;
  final String comment;
  final int rating;
  final List<String> likes;
  final DateTime timestamp;

  ReviewModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.comment,
    required this.rating,
    required this.likes,
    required this.timestamp,
  });

  factory ReviewModel.fromMap(String id, Map<String, dynamic> data) {
    return ReviewModel(
      id: id,
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      comment: data['comment'] ?? '',
      rating: data['rating'] ?? 0,
      likes: List<String>.from(data['likes'] ?? []),
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'comment': comment,
      'rating': rating,
      'likes': likes,
      'timestamp': timestamp,
    };
  }
}
