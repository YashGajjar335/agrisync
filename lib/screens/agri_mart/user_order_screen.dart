import 'package:agrisync/model/order.dart';
import 'package:agrisync/model/product.dart';
import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({super.key});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const MainScreen())),
          ),
          title: const AgriSyncIcon(
            title: "My Orders",
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(orderCollection)
              .where("userId", isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                int itemCount = snapshot.data!.size;
                return itemCount == 0
                    ? const Center(
                        child: TextLato(
                          text: "You have no orders yet. Start shopping now!",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: itemCount,
                            itemBuilder: (context, item) {
                              OrderModel orderModel = OrderModel.fromSnap(
                                  snapshot.data!.docs[item]);

                              return Card(
                                child: ExpansionTile(
                                    initiallyExpanded: true,
                                    title: Text(
                                        "Order At : ${simplyDateFormat(time: orderModel.orderDate, dateOnly: true)}"),
                                    children: [
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: orderModel.items.length,
                                        itemBuilder: (context, index) {
                                          String productId = orderModel
                                              .items.keys
                                              .elementAt(index);
                                          int quantity = orderModel.items.values
                                              .elementAt(index);

                                          return FutureBuilder(
                                            future: AgriMartServiceUser.instance
                                                .getProduct(productId),
                                            builder: (context, snap) {
                                              if (snap.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snap.hasError) {
                                                return const Center(
                                                    child: Text(
                                                        'Error loading product'));
                                              } else if (!snap.hasData ||
                                                  snap.data == null) {
                                                return const Center(
                                                    child: Text(
                                                        'Product not found'));
                                              }

                                              Products product = snap.data!;
                                              return Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                elevation: 5,
                                                margin: const EdgeInsets.only(
                                                    bottom: 16,
                                                    right: 10,
                                                    left: 10),
                                                child: ListTile(
                                                  leading: StringImageInCircleAvatar(
                                                      base64ImageString: product
                                                          .productImageUrl[0]),
                                                  title: TextLato(
                                                    text: product.productName,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  subtitle: TextLato(
                                                    text: "₹ ${product.price}",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  trailing: TextLato(
                                                    text:
                                                        'X $quantity = ₹ ${product.price * quantity}',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      )
                                    ]),
                              );
                            }),
                      );
              } else {
                return const WaitingScreenWithWarnning();
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WaitingScreen();
            }
            return const WaitingScreenWithWarnning();
          },
        ));
  }
}
