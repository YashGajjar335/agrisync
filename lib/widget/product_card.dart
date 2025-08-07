import 'package:agrisync/model/product.dart';
import 'package:agrisync/screens/agri_mart/product_detail_screen.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCard extends StatelessWidget {
  final Products products;

  const ProductCard({
    super.key,
    required this.products,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Stack(
        children: [
          Container(
            // width: 145,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                if (products.stockQuantity != 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                                products: products,
                              )));
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  StringImage(
                    height: 150,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(12),
                    base64ImageString: products.productImageUrl[0],
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextLato(
                      text: products.productName,
                      maxLine: 2,
                      fontWeight: FontWeight.bold,
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
          if (products.stockQuantity <= 0)
            Positioned(
                child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: TextLato(
                  text: AppLocalizations.of(context)!.out_of_stock,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  paddingAll: 10,
                  color: Colors.white,
                ),
              ),
            )),
        ],
      ),
    );
  }
}
