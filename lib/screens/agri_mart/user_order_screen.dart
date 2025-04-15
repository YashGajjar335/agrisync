import 'package:agrisync/model/order.dart';
import 'package:agrisync/model/product.dart';
import 'package:agrisync/screens/main_screen.dart';
import 'package:agrisync/services/agri_mart_service_user.dart';
import 'package:agrisync/services/invoice_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({super.key});

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  bool isDownload = false;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return PopScope(
      onPopInvoked: (pop) async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MainScreen(
                    initPage: 2,
                  )),
          (route) => false,
        );
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            bottomOpacity: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MainScreen())),
            ),
            title: AgriSyncIcon(
              title: appLocalizations.my_order,
            ),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(orderCollection)
                .where("userId",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  int itemCount = snapshot.data!.size;
                  return itemCount == 0
                      ? Center(
                          child: TextLato(
                            text: appLocalizations.noOrders,
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
                                      title: TextLato(
                                          text:
                                              "${appLocalizations.my_order} : ${item + 1}"),
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
                                            int quantity = orderModel
                                                .items.values
                                                .elementAt(index);

                                            return FutureBuilder(
                                              future: AgriMartServiceUser
                                                  .instance
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    subtitle: TextLato(
                                                      text:
                                                          "₹ ${product.price}",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    trailing: TextLato(
                                                      text:
                                                          'X $quantity = ₹ ${product.price * quantity}',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        OrderStatusCard(
                                            orderDate: simplyDateFormat(
                                                time: orderModel.orderDate,
                                                dateOnly: true),
                                            paymentStatus: "PAID",
                                            shippedDate:
                                                orderModel.shippingDate,
                                            // simplyDateFormat(
                                            //     time: orderModel
                                            //         .shippingDate!,
                                            //     dateOnly: true),
                                            deliveryDate:
                                                orderModel.deliveryDate
                                            // : simplyDateFormat(
                                            //     time: orderModel
                                            //         .deliveryDate!,
                                            //     dateOnly: true),
                                            ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Center(
                                              child: LongButton(
                                                  isLoading: isDownload,
                                                  width: 200,
                                                  buttonText: appLocalizations
                                                      .downloadInvoice,
                                                  onTap: () async {
                                                    setState(() {
                                                      isDownload = true;
                                                    });
                                                    final firstPdf =
                                                        await InvoiceServices
                                                            .generateInvoice(
                                                      orderModel: orderModel,
                                                    );
                                                    InvoiceServices.openInvoice(
                                                        firstPdf);
                                                    setState(() {
                                                      isDownload = false;
                                                    });
                                                  })),
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
          )),
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  final String orderDate;
  final String paymentStatus;
  final DateTime? shippedDate;
  final DateTime? deliveryDate;

  const OrderStatusCard({
    super.key,
    required this.orderDate,
    required this.paymentStatus,
    this.shippedDate,
    this.deliveryDate,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLato(
                text: appLocalizations.orderStatus,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            const SizedBox(height: 16),
            Stepper(
              physics: const NeverScrollableScrollPhysics(),
              currentStep: _getCurrentStep(),
              steps: _buildSteps(context),
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Container();
              },
              controller: null,
            ),
          ],
        ),
      ),
    );
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int _getCurrentStep() {
    DateTime now = DateTime.now();

    if (deliveryDate != null &&
        (isSameDate(deliveryDate!, now) || deliveryDate!.isBefore(now))) {
      return 3;
    }

    if (shippedDate != null &&
        (isSameDate(shippedDate!, now) || shippedDate!.isBefore(now))) {
      return 2;
    }

    if (paymentStatus.toLowerCase() == "done") {
      return 1;
    }

    return 0;
  }

  List<Step> _buildSteps(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    int currentStep = _getCurrentStep();

    return [
      _buildStep(appLocalizations.orderPlaced, orderDate, 0, currentStep),
      _buildStep(
          appLocalizations.paymentProcessed, paymentStatus, 1, currentStep),
      _buildStep(
          appLocalizations.shipped,
          shippedDate != null
              ? simplyDateFormat(time: shippedDate!, dateOnly: true)
              : appLocalizations.pending,
          2,
          currentStep),
      _buildStep(
          appLocalizations.delivered,
          deliveryDate != null
              ? simplyDateFormat(time: deliveryDate!, dateOnly: true)
              : appLocalizations.pending,
          3,
          currentStep),
    ];
  }

  Step _buildStep(
      String title, String subtitle, int stepIndex, int currentStep) {
    bool isActive = stepIndex <= currentStep;
    bool isCurrent = stepIndex == currentStep;

    return Step(
      title: TextLato(
        text: title,
        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
        color: isCurrent ? Colors.green : Colors.black,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          color: isCurrent ? Colors.green : Colors.grey,
        ),
      ),
      isActive: isActive,
      state: isActive ? StepState.complete : StepState.indexed,
      content: const SizedBox.shrink(),
    );
  }
}
