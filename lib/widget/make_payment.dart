// import 'package:agrisync/model/payment.dart';
// import 'package:agrisync/services/stripe_services.dart';
// import 'package:agrisync/widget/long_button.dart';
// import 'package:flutter/material.dart';

// class MakePayment extends StatefulWidget {
//   final double amount;
//   const MakePayment({super.key, required this.amount});

//   @override
//   State<MakePayment> createState() => _MakePaymentState();
// }

// class _MakePaymentState extends State<MakePayment> {
//   bool isLoad = false;
//   @override
//   Widget build(BuildContext context) {
//     return LongButton(
//       width: double.infinity,
//       isLoading: isLoad,
//       buttonText: "Make Payment",
//       onTap: () async {
//         setState(() {
//           isLoad = true;
//         });
//         StripeServices paymentService = StripeServices.instance;
//         Payment payment = await paymentService
//             .makePaymentGetPayment(widget.amount)
//             .whenComplete(() {
//           setState(() {
//             isLoad = false;
//           });
//         });
//       },
//     );
//   }
// }
