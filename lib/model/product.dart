import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final double price, size, id;
  final Color color;

  Product({
    required this.id,
    required this.image,
    required this.color,
    required this.description,
    required this.price,
    required this.size,
    required this.title,
  });
}

// for project implimantation
class Products {
  String productId;
  String name;
  String description;
  String category;
  double price;
  String unit;
  int stockQuantity;
  List<String> imageUrl;
  DateTime createdAt;
  DateTime expireAt;
  String status; // Available or not
  double averageRating;

  Products({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.unit,
    required this.stockQuantity,
    required this.imageUrl,
    required this.createdAt,
    required this.expireAt,
    required this.status,
    required this.averageRating,
  });

  // Convert a Product object to a Map
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'description': description,
        'category': category,
        'price': price,
        'unit': unit,
        'stockQuantity': stockQuantity,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.fromDate(createdAt),
        'expireAt': Timestamp.fromDate(expireAt),
        'status': status,
        'averageRating': averageRating,
      };

  // Create a Product object from a Map
  factory Products.fromSnap(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return Products(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      unit: map['unit'] ?? '',
      stockQuantity: map['stockQuantity'] ?? 0,
      imageUrl: List<String>.from(map['imageUrl'] ?? []),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      expireAt: (map['expireAt'] as Timestamp).toDate(),
      status: map['status'] ?? 'unavailable',
      averageRating: map['averageRating'] ?? 0.0,
    );
  }
}

Products product = Products(
  productId: "123",
  name: "Product Name",
  description: "This is a test product",
  category: "Fertilizers",
  price: 100.0,
  unit: "kg",
  stockQuantity: 50,
  imageUrl: ["This is First ImageUrl ", "This is second"],
  createdAt: DateTime.now(),
  expireAt: DateTime.now().add(const Duration(days: 30)),
  status: "available",
  averageRating:
      12, // this is find from the poductReview all the review's ratinf devide by the
);
