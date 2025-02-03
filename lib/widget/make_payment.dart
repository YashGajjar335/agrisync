import 'package:agrisync/services/stripe_services.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:flutter/material.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({super.key});

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  @override
  Widget build(BuildContext context) {
    bool _isLoad = false;
    return LongButton(
      width: double.infinity,
      buttonText: _isLoad ? "Wait.." : "Make Payment",
      onTap: () {
        setState(() {
          _isLoad = true;
        });
        StripeServices payment = StripeServices.instance;
        payment.makePayment().whenComplete(() {
          setState(() {
            _isLoad = false;
          });
        });
      },
    );
  }
}
