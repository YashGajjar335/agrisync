import 'package:agrisync/model/product.dart';
import 'package:agrisync/widget/product_card.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowProduct extends StatefulWidget {
  final String categories;
  const ShowProduct({super.key, required this.categories});

  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLato(text: widget.categories),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Products")
              .where("categories", arrayContains: widget.categories)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                final int item = snapshot.data!.size;
                return item == 0
                    ? const Center(
                        child: TextLato(
                          text: "No Product avilable..!",
                        ),
                      )
                    : ListView.builder(
                        itemCount: item,
                        itemBuilder: (context, i) {
                          return ProductCard(
                              products:
                                  Products.fromSnap(snapshot.data!.docs[i]));
                        },
                      );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WaitingScreen();
            }
            return const WaitingScreen();
          }),
    );
  }
}
