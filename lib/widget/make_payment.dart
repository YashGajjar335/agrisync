import 'package:agrisync/services/stripe_services.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:flutter/material.dart';

class MakePayment extends StatelessWidget {
  const MakePayment({super.key});

  @override
  Widget build(BuildContext context) {
    return LongButton(
        width: double.infinity,
        name: "Make Payment",
        onTap: () => StripeServices.instance.makePayment);
  }
}
