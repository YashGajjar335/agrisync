import 'package:agrisync/model/product.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Product? products;
  final Function() onPress;

  const ItemCard({
    super.key,
    required this.onPress,
    this.products,
  });
  @override
  Widget build(BuildContext context) {
    Product product = Product(
        id: 01,
        image: "assets/farm.png",
        color: Colors.transparent,
        description: "description",
        price: 500,
        size: 10,
        title: "Product");
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: 145,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: onPress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    product.image,
                    height: 180,
                    width: 150,
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  product.title,
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "${product.price}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
