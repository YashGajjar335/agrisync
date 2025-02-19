// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/model/order.dart';
import 'package:agrisync/model/product.dart';
import 'package:agrisync/model/user_address.dart';
import 'package:agrisync/screens/agri_mart/add_address.dart';
import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/make_payment.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:flutter/material.dart';

class ProductOrderScreen extends StatefulWidget {
  final Map<String, int> productList;
  const ProductOrderScreen({super.key, required this.productList});

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  // List<Products> productList = [];
  UserAddress? userAddress;
  double totalamount = 0;
  bool isLoadAddress = false;
  bool isLoadProduct = false;

  @override
  void initState() {
    calculateTotalPrice();
    loadAddress();
    super.initState();
  }

  calculateTotalPrice() {
    widget.productList.forEach((productId, quantity) async {
      Products? product =
          await AgriMartServiceUser.instance.getProduct(productId);
      if (product != null) {
        setState(() {
          totalamount += (product.price * quantity);
        });
      } else {
        showSnackBar("Product total price failed ", context);
      }
    });
  }

  loadAddress() async {
    setState(() {
      isLoadAddress = true;
    });
    AgriMartServiceUser agrimartservice = AgriMartServiceUser.instance;
    userAddress = await agrimartservice.getUserAddress();
    setState(() {
      isLoadAddress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff338864),
        title: Text(
          'Order Details',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16, right: 10, left: 10),
              child: ListView.builder(
                itemCount: widget.productList.length,
                itemBuilder: (context, item) {
                  widget.productList.forEach((productId, quantity) {
                    FutureBuilder(
                      future:
                          AgriMartServiceUser.instance.getProduct(productId),
                      builder: (context, snap) {
                        Products? product = snap.data;
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                          margin: const EdgeInsets.only(
                              bottom: 16, right: 10, left: 10),
                          child: ListTile(
                            leading: StringImage(
                                base64ImageString: product!.productImageUrl[0]),
                            title: TextLato(
                                text: product.productName,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            subtitle: TextLato(
                                text: "₹ ${product.price}",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
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
                  });
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16, right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TextLato(
                    text: "Total Amount : ",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  TextLato(
                    text: "₹ $totalamount",
                  )
                ],
              ),
            ),
            isLoadAddress
                ? Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 10, right: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextLato(
                                text: 'Shipping Address',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(color: Colors.grey)),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddAddress()));
                                    },
                                    child: TextLato(
                                        text: userAddress == null
                                            ? 'Add Address'
                                            : 'Chnage',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          if (userAddress != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextLato(
                                    text: 'Street: ${userAddress!.street}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                    text: 'City: ${userAddress!.city}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                    text: 'State: ${userAddress!.state}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                  text:
                                      'Postal Code: ${userAddress!.postalCode}',
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 100,
                    child: WaitingScreen(),
                  ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16, right: 10, left: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MakePayment(amount: totalamount),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: ElevatedButton(
                onPressed: () {
                  Order order = Order(
                    orderId: "123",
                    userId: "userId",
                    items: widget.productList,
                    totalAmount: totalamount,
                    paymentMethod: "Card",
                    orderStatus: "orderStatus",
                    orderDate: DateTime.now(),
                    addressId: "addressId",
                    transactionId: "transactionId",
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order Confirmed')));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color(0xff338864),
                ),
                child: const TextLato(
                  text: 'Confirm Order',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
