import 'dart:ui';

import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
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
