import 'package:agrisync/model/product.dart';
import 'package:agrisync/widget/item_card.dart';
import 'package:agrisync/screens/item_detail_screen.dart';
import 'package:agrisync/widget/agri_mart_categories.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
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
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
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
            const Text(
              'Catogary',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemsDetailsPage(
                                  product: products,
                                )),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
