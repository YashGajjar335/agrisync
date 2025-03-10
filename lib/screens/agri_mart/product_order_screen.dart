// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/model/payment.dart';
import 'package:agrisync/model/product.dart';
import 'package:agrisync/model/user_address.dart';
import 'package:agrisync/screens/agri_mart/add_address.dart';
import 'package:agrisync/screens/agri_mart/user_order_screen.dart';
import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/services/stripe_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ProductOrderScreen extends StatefulWidget {
  final Map<String, int> productList;
  const ProductOrderScreen({super.key, required this.productList});

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  // List<Products> productList = [];
  UserAddress? userAddress;
  Payment? payment;
  double totalAmount = 0;
  bool isLoadAddress = false;
  bool isLoadProduct = false;
  bool isLoadPayment = false;

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
          totalAmount += (product.price * quantity);
        });
      } else {
        showSnackBar("Product total price failed ", context);
      }
    });
  }

  loadAddress() async {
    setState(() {
      isLoadAddress = false;
    });
    AgriMartServiceUser agrimartservice = AgriMartServiceUser.instance;
    userAddress = await agrimartservice.getUserAddress();
    print(userAddress == null);
    isLoadAddress = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff338864),
        title: Text(
          appLocalizations.order_details,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(08),
        child: ListView(
          children: [
            // product List
            Card(
              margin: const EdgeInsets.all(8),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.productList.length,
                itemBuilder: (context, index) {
                  String productId = widget.productList.keys.elementAt(index);
                  int quantity = widget.productList.values.elementAt(index);

                  return FutureBuilder(
                    future: AgriMartServiceUser.instance.getProduct(productId),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snap.hasError) {
                        return Center(
                            child:
                                Text(appLocalizations.error_loading_product));
                      } else if (!snap.hasData || snap.data == null) {
                        return Center(
                            child: TextLato(
                                text: appLocalizations.product_not_found));
                      }

                      Products product = snap.data!;
                      return Card(
                        child: ListTile(
                          leading: StringImageInCircleAvatar(
                            base64ImageString: product.productImageUrl[0],
                          ),
                          title: TextLato(
                            text: product.productName,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: TextLato(
                            text: "₹ ${product.price}",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: TextLato(
                            text: 'X $quantity = ₹ ${product.price * quantity}',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // total amount
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16, right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextLato(
                    text: "${appLocalizations.total_price} : ",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  TextLato(
                    text: "₹ $totalAmount",
                  )
                ],
              ),
            ),
            // address
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
                              TextLato(
                                text: appLocalizations.shipping_address,
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
                                            ? appLocalizations.add_address
                                            : appLocalizations.change,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          // userAddress
                          if (userAddress != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextLato(
                                    text:
                                        '${appLocalizations.name} : ${userAddress!.fullName}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                    text:
                                        '${appLocalizations.mobile_no} : ${userAddress!.phoneNumber}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                    text:
                                        '${appLocalizations.flat_no} : ${userAddress!.flatNumber}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                    text:
                                        '${appLocalizations.street_road} : ${userAddress!.streetRoad}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                    text:
                                        '${appLocalizations.street} : ${userAddress!.street}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                    text:
                                        '${appLocalizations.city} : ${userAddress!.city}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                    text:
                                        '${appLocalizations.state} : ${userAddress!.state}',
                                    fontSize: 15,
                                    color: Colors.black87),
                                TextLato(
                                  text:
                                      '${appLocalizations.postal_code} : ${userAddress!.postalCode}',
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
            // make payment
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16, right: 10, left: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LongButton(
                  width: double.infinity,
                  isLoading: isLoadPayment,
                  buttonText: appLocalizations.make_payment,
                  onTap: () async {
                    setState(() {
                      isLoadPayment = true;
                    });

                    try {
                      if (userAddress == null) {
                        showSnackBar(appLocalizations.fill_address, context);
                      } else {
                        StripeServices paymentService = StripeServices.instance;
                        payment = await paymentService
                            .makePaymentGetPayment(totalAmount);

                        if (payment == null || payment!.status == "failed") {
                          showSnackBar(
                              appLocalizations.payment_failed, context);
                        } else {
                          final res = await AgriMartServiceUser.instance
                              .confirmOrder(payment!, widget.productList,
                                  totalAmount, userAddress!.id);

                          if (res == null) {
                            showSnackBar(
                                appLocalizations.order_confirmed, context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const UserOrderScreen()));
                          } else {
                            showSnackBar(res.toString(), context);
                          }
                        }
                      }
                    } catch (e) {
                      showSnackBar("Error: ${e.toString()}", context);
                    } finally {
                      setState(() {
                        isLoadPayment = false;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
