import 'package:agrisync/model/product.dart';
import 'package:agrisync/screens/agri_mart_cart_screen.dart';
import 'package:agrisync/widget/add_to_cart_buy_button.dart';
import 'package:agrisync/widget/out_lined_button.dart';
import 'package:flutter/material.dart';

class ItemsDetailsPage extends StatefulWidget {
  final Product product;
  const ItemsDetailsPage({super.key, required this.product});

  @override
  State<ItemsDetailsPage> createState() => _ItemsDetailsPageState();
}

class _ItemsDetailsPageState extends State<ItemsDetailsPage> {
  int noOfProduct = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff338864),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () => print('this is for Search'),
              icon: const Icon(Icons.search, color: Colors.white)),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AgriMartCartScreen()),
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
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(top: size.height * 0.12, left: 20.0),
                    margin: EdgeInsets.only(top: size.height * 0.39),
                    height: 500,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        )),
                    child: Column(
                      children: [
                        //  ProductManufactureAndExpireDate
                        const Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Manufacture Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '28/01/2028',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expire Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '28/01/2028',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        //product description
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            widget.product.description,
                            style: const TextStyle(
                                height: 1.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // product count
                        Row(
                          children: <Widget>[
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                  noOfProduct.toString().padLeft(2, '0'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            ),
                            OutLinedButton(
                                icons: Icons.add,
                                onPress: () {
                                  setState(() {
                                    noOfProduct++;
                                  });
                                }),
                          ],
                        ),
                        const SizedBox(height: 10),
                        AddToCartBuyButton(product: widget.product),
                        const SizedBox(height: 10),
                        const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 240),
                              child: Text(
                                'Rating & Review',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // ProductTitleWithImage(product: widget.product),x`
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'ProductName',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.product.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(text: 'Price\n'),
                                  TextSpan(
                                    text: '\$${widget.product.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            // Spacer(), jo spaccer no use karsu to iamge baju ma aavse please ak var try karo hahahaha
                            Expanded(
                                child: Hero(
                              tag: '${widget.product.id}',
                              child: Image.asset(
                                widget.product.image,
                                fit: BoxFit.scaleDown,
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
