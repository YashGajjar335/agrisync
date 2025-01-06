import 'package:agrisync/shopping_page/product.dart';
import 'package:flutter/material.dart';

class Itemdetailspage extends StatelessWidget {
  final Product? product;

  const Itemdetailspage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final product = Product(
        id: 01,
        image: "assets/farm.png",
        color: Colors.transparent,
        description: "description",
        price: 500,
        size: 10,
        title: "Product");
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar.new(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_sharp)),
      ),
    );
  }
}
