import 'package:agrisync/shopping_page/Product.dart';
import 'package:agrisync/shopping_page/item_count.dart';
import 'package:agrisync/shopping_page/item_detail_page.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  Product products = Product(
      id: 01,
      image: "assets/farm.png",
      color: Colors.transparent,
      description: "description",
      price: 500,
      size: 10,
      title: "Product");

  final List<String> images = [
    'assets/farm.png',
    'assets/farm.png',
    'assets/farm.png',
    'assets/farm.png',
    'assets/farm.png',
    'assets/farm.png',
  ];

  final List<String> textField = [
    'Fertilizer',
    'Pesticides',
    'Seeds',
    'Equipment',
    'Pesticides',
    'Fertilizer'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          'Shopping Page',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) {
                  return ClipRect(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10, bottom: 10, right: 10, top: 10),
                      width: 110, // Set width as per requirement
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Image in ClipRect
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: GestureDetector(
                                onTap: () {
                                  print('Image is cliable');
                                },
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.fill,
                                  height: 100,
                                  width: 100,
                                )),
                          ),
                          SizedBox(
                              height: 5), // Space between image and text field
                          // TextField in ClipRect
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Text(
                                textField[index],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
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
