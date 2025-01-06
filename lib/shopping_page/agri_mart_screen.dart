import 'package:agrisync/shopping_page/Product.dart';
import 'package:agrisync/shopping_page/item_count.dart';
import 'package:agrisync/shopping_page/item_detail_page.dart';
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
      id: 01,
      image: "assets/farm.png",
      color: Colors.transparent,
      description: "description",
      price: 500,
      size: 10,
      title: "Product");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "AgriMart"),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 10),
            onPressed: () {
              print('Add to Cart');
            },
            icon: Icon(Icons.shopping_cart_rounded),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                prefixIcon: Icon(Icons.search),
                iconColor: Colors.grey,
              ),
            ),
            Text(
              'Catogary',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            AgriMartCategories(),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            SizedBox(height: 5),
            Text(
              'Fertilizer',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) => ItemCount(
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Itemdetailspage()),
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
