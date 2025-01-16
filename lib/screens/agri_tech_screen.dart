// import 'package:agrisync/screens/payment_screen.dart';
// import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/services/stripe_services.dart';
import 'package:flutter/material.dart';

class AgriTechScreen extends StatelessWidget {
  const AgriTechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            StripeServices.instance.makePayment();
          },
          child: const Icon(
            Icons.payment_rounded,
            size: 30,
          ),
        ),
      ),
    );
  }
}
