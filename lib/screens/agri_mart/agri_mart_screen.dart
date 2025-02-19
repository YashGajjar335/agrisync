import 'package:agrisync/model/product.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/product_card.dart';
import 'package:agrisync/screens/agri_mart/product_detail_screen.dart';
import 'package:agrisync/widget/agri_mart_categories.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AgriMartScreen extends StatefulWidget {
  const AgriMartScreen({super.key});

  @override
  State<AgriMartScreen> createState() => _AgriMartScreenState();
}

class _AgriMartScreenState extends State<AgriMartScreen> {
  Product products = Product(
      id: 1,
      image: 'assets/farm.png',
      color: Colors.black,
      description:
          'Often called Lord Krishna, he is one of the most widely worshiped and popular Hindu deities. Krishna is the eighth avatar (or incarnation) of Vishnu',
      price: 280,
      size: 12,
      title: 'Title 1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "AgriMart"),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {
              print('Add to Cart');
            },
            icon: const Icon(Icons.shopping_cart_rounded),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: TextField(
              cursorColor: Colors.red,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                isDense: true,
                fillColor: Colors.transparent,
                filled: true,
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                iconColor: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextLato(
              text: 'Catogary',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            const AgriMartCategories(),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            const Text(
              'Fertilizer',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Products")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          int size = snapshot.data!.size;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: size,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.60,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                              products: Products.fromSnap(
                                snapshot.data!.docs[index],
                              ),
                            ),
                          );
                        } else {
                          return const WaitingScreen();
                        }
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const WaitingScreen();
                      }

                      return const WaitingScreenWithWarnning();
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
