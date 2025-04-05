import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class Product {
//   final String image, title, description;
//   final double price, size, id;
//   final Color color;

//   Product({
//     required this.id,
//     required this.image,
//     required this.color,
//     required this.description,
//     required this.price,
//     required this.size,
//     required this.title,
//   });
// }

// for project implimantation
class Products {
  String productId;
  String productName;
  String description;
  List<String> categories;
  double price;
  String unit;
  int stockQuantity;
  List<String> productImageUrl;
  DateTime createdAt;
  DateTime expireAt;
  double averageRating;

  Products({
    required this.productId,
    required this.productName,
    required this.description,
    required this.categories,
    required this.price,
    required this.unit,
    required this.stockQuantity,
    required this.productImageUrl,
    required this.createdAt,
    required this.expireAt,
    required this.averageRating,
  });

  // Convert a Product object to a Map
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': productName,
        'description': description,
        'categories': categories,
        'price': price,
        'unit': unit,
        'stockQuantity': stockQuantity,
        'imageUrl': productImageUrl,
        'createdAt': Timestamp.fromDate(createdAt),
        'expireAt': Timestamp.fromDate(expireAt),
      };

  // Create a Product object from a Map
  factory Products.fromSnap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return Products(
      productId: map['productId'] ?? '',
      productName: map['name'] ?? '',
      description: map['description'] ?? '',
      categories: List<String>.from(map['categories'] ?? []),
      price: (map['price'] ?? 0).toDouble(),
      unit: map['unit'] ?? '',
      stockQuantity: map['stockQuantity'] ?? 0,
      productImageUrl: List<String>.from(map['imageUrl'] ?? []),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      expireAt: (map['expireAt'] as Timestamp).toDate(),
      averageRating: map['averageRating'] ?? 0.0,
    );
  }
}

// Products product = Products(
//   productId: "123",
//   productName: "Product Name",
//   description: "This is a test product",
//   categories: ["Fertilizers"],
//   price: 100.0,
//   unit: "kg",
//   stockQuantity: 50,
//   productImageUrl: ["This is First ImageUrl ", "This is second"],
//   createdAt: DateTime.now(),
//   expireAt: DateTime.now().add(const Duration(days: 30)),
//   averageRating:
//       12, // this is find from the poductReview all the review's ratinf devide by the
// );
