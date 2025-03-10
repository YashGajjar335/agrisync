import 'package:agrisync/model/product.dart';
import 'package:agrisync/screens/agri_mart/my_cart_screen.dart';
import 'package:agrisync/widget/product_card.dart';
import 'package:agrisync/widget/agri_mart_categories.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AgriMartScreen extends StatefulWidget {
  const AgriMartScreen({super.key});

  @override
  State<AgriMartScreen> createState() => _AgriMartScreenState();
}

class _AgriMartScreenState extends State<AgriMartScreen> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: AgriSyncIcon(title: appLocalizations.agrimart),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MyCartScreen()));
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
                hintText: appLocalizations.search,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextLato(
                text: appLocalizations.category,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const AgriMartCategories(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              ' ',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Products")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
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

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const WaitingScreen();
                        }

                        return const WaitingScreenWithWarnning();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
