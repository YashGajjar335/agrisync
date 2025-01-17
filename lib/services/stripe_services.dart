// ignore_for_file: avoid_print

import 'dart:async';

import 'package:agrisync/utils/stripe_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServices {
  StripeServices._();
  static final StripeServices instance = StripeServices._();

  Future<void> makePayment() async {
    try {
      String? paymetnIntentClientSecret =
          await _createPaymentIntent(1000000, "INR");
      print("paymetnIntentClientSecret : $paymetnIntentClientSecret");
      if (paymetnIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymetnIntentClientSecret,
          merchantDisplayName: "Yash Gajjar",
        ),
      );
      await _processPayment();
    } catch (e) {
      print("make payment : $e");
    }
  }

  Future<String?> _createPaymentIntent(double amount, String currency) async {
    try {
      final Dio dio = Dio();
      const String url = "https://api.stripe.com/v1/payment_intents";
      String privateKey = StripeKeys().privatekey;

      Map<String, dynamic> headers = {
        'Authorization': "Bearer $privateKey",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      var response = await dio.post(url,
          data: data,
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: headers));

      print(response);
      if (response.data != null) {
        // print(response.data["client_secret"]);

        return response.data["client_secret"];
      }
    } catch (e) {
      print("_createPaymentIntent(amount, currency) : $e");
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print("_processPayment : $e");
    }
  }

  String _calculateAmount(double amt) {
    int calculatedAmount = (amt * 100).toInt();
    return calculatedAmount.toString();
  }
}
