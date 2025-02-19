import 'package:agrisync/model/product.dart';
import 'package:agrisync/screens/agri_mart/product_detail_screen.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Products products;

  const ProductCard({
    super.key,
    required this.products,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: 145,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                        products: products,
                      ))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Expanded(
                child: StringImage(
                  borderRadius: BorderRadius.circular(12),
                  base64ImageString: products.productImageUrl[0],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextLato(
                  text: products.productName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextLato(
                  text: "₹ ${products.price}",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
