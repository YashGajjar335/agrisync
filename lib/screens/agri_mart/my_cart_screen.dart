import 'package:agrisync/model/cart_items.dart';
import 'package:agrisync/model/product.dart';
import 'package:agrisync/screens/agri_mart/product_detail_screen.dart';
import 'package:agrisync/screens/agri_mart/product_order_screen.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AgriSyncIcon(title: "My Cart")),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("userCart")
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingScreen();
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: TextLato(text: "Your cart is empty."));
          }

          CartItems cartItems = CartItems.fromSnap(snapshot.data!);
          List<String> productIds = cartItems.products.keys.toList();

          return Scaffold(
            body: ListView.builder(
              itemCount: productIds.length,
              itemBuilder: (context, index) {
                String productId = productIds[index];
                int quantity = cartItems.products[productId] ?? 1;

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("Products")
                      .doc(productId)
                      .get(),
                  builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const WaitingScreen();
                    }
                    if (!productSnapshot.hasData ||
                        !productSnapshot.data!.exists) {
                      return const Center(
                          child: TextLato(text: "Product not found."));
                    }

                    Products product = Products.fromSnap(productSnapshot.data!);

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: ExpansionTile(
                        leading: StringImageInCircleAvatar(
                            base64ImageString: product.productImageUrl[0]),
                        title: TextLato(text: product.productName),
                        subtitle: TextLato(text: "₹ ${product.price}"),
                        trailing: TextLato(text: "X $quantity"),
                        children: [
                          const TextLato(
                              text: "Product Info:",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          TextLato(text: product.description),
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailsPage(products: product)),
                            ),
                            child: const TextLato(text: "Show More"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: Expanded(
              child: FloatingActionButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProductOrderScreen(
                            productList: cartItems.products))),
                child: TextLato(
                  text: "buy now".toUpperCase(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
