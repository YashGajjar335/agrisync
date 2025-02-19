import 'package:cloud_firestore/cloud_firestore.dart';

class ProductReview {
  String productId;
  String uid;
  String review;
  double rating;

  ProductReview(
      {required this.productId,
      required this.uid,
      required this.review,
      required this.rating});

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'uid': uid,
      'review': review,
      'rating': rating,
    };
  }

  static ProductReview fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;
    return ProductReview(
      productId: map['productId'] ?? "",
      uid: map['uid'] ?? "",
      review: map['review'] ?? "",
      rating: map['rating'] ?? 0.0,
    );
  }
}
