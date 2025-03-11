import 'package:agrisync/model/product.dart';
import 'package:agrisync/screens/agri_mart/add_review.dart';
import 'package:agrisync/screens/agri_mart/my_cart_screen.dart';
import 'package:agrisync/screens/agri_mart/product_review_screen.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/add_to_cart_buy_button.dart';
import 'package:agrisync/widget/out_lined_button.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsPage extends StatefulWidget {
  final Products products;
  const ProductDetailsPage({super.key, required this.products});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int noOfProduct = 1;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff338864),
        title: TextLato(
          text: widget.products.productName,
          color: Colors.white,
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            )),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyCartScreen()),
            ),
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // detailing
                Container(
                  padding:
                      EdgeInsets.only(top: height(context) * 0.30, left: 20.0),
                  margin: EdgeInsets.only(top: height(context) * 0.36),
                  // padding: EdgeInsets.only(top: 400, left: 16),
                  // height: 500,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      )),
                  child: Column(
                    children: [
                      //  ProductManufactureAndExpireDate
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextLato(
                                text: appLocalizations.manufacture_date,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              TextLato(
                                  text: simplyDateFormat(
                                      dateOnly: true,
                                      time: widget.products.createdAt),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextLato(
                                text: appLocalizations.expire_date,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              TextLato(
                                  text: simplyDateFormat(
                                      dateOnly: true,
                                      time: widget.products.expireAt),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      //product description
                      TextLato(text: appLocalizations.product_info),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            widget.products.description,
                            softWrap: true,
                          )),
                      const SizedBox(height: 10),
                      // product count button
                      Row(children: [
                        OutLinedButton(
                            icons: Icons.remove,
                            onPress: () {
                              if (noOfProduct > 1) {
                                setState(() {
                                  noOfProduct--;
                                });
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(noOfProduct.toString().padLeft(2, '0'),
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        ),
                        OutLinedButton(
                            icons: Icons.add,
                            onPress: () {
                              if (noOfProduct ==
                                  widget.products.stockQuantity) {
                                showSnackBar(
                                    appLocalizations.out_of_stock, context);
                              } else {
                                setState(() {
                                  noOfProduct++;
                                });
                              }
                            }),
                      ]),
                      const SizedBox(height: 10),
                      // add to cart button
                      AddToCartAndBuyButton(
                        products: widget.products, nuOfProduct: noOfProduct,
                        // addressId: ,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                // Product Image and title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLato(
                        text: appLocalizations.product_name,
                        color: Colors.black,
                      ),
                      TextLato(
                        text: widget.products.productName,
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: '${appLocalizations.price} \n',
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                                TextSpan(
                                    text: "${widget.products.price} ₹",
                                    style: GoogleFonts.lato(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // const Spacer(), //jo spaccer no use karsu to iamge baju ma aavse please ak var try karo hahahaha
                          Expanded(
                            child: Hero(
                              tag: widget.products.productId,
                              child: TweenAnimationBuilder(
                                duration: const Duration(
                                    milliseconds:
                                        500), // Adjust duration as needed
                                tween: Tween<double>(
                                    begin: 0.5, end: 1.0), // Scale effect
                                builder: (context, double scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: child,
                                  );
                                },
                                child: StringImage(
                                  height: 380,
                                  borderRadius: BorderRadius.circular(20),
                                  base64ImageString:
                                      widget.products.productImageUrl[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //product review screen and rating screen
            ProductReviewScreen(productId: widget.products.productId)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    AddReviewForProduct(productId: widget.products.productId))),
        child: const Icon(Icons.rate_review_rounded),
      ),
    );
  }
}
