// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/model/product.dart';
import 'package:agrisync/screens/agri_mart/product_order_screen.dart';
import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class AddToCartAndBuyButton extends StatefulWidget {
  // final String addressId;
  final Products products;
  final int nuOfProduct;
  const AddToCartAndBuyButton({
    super.key,
    // required this.addressId,
    required this.products,
    required this.nuOfProduct,
  });

  @override
  State<AddToCartAndBuyButton> createState() => _AddToCartAndBuyButtonState();
}

class _AddToCartAndBuyButtonState extends State<AddToCartAndBuyButton> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary)),
            child: IconButton(
              onPressed: () async {
                final res = await AgriMartServiceUser.instance
                    .addToCart(widget.products.productId);
                showSnackBar(
                    res ?? appLocalizations.products_added_to_cart, context);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          Expanded(
            child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                        0xff338864,
                      )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductOrderScreen(
                                    productList: {
                                      widget.products.productId:
                                          widget.nuOfProduct
                                    },
                                  )),
                        );
                      },
                      child: TextLato(
                        text: appLocalizations.buy,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
