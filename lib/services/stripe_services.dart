// ignore_for_file: avoid_print

import 'dart:async';

import 'package:agrisync/model/payment.dart';
import 'package:agrisync/utils/stripe_keys.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:uuid/uuid.dart';

class StripeServices {
  StripeServices._();
  static final StripeServices instance = StripeServices._();
  Payment? payment;

  Future<Payment?> makePaymentGetPayment(double amount) async {
    await makePayment(amount);
    return payment;
  }

  Future<void> makePayment(double amount) async {
    try {
      String? paymetnIntentClientSecret =
          await _createPaymentIntent(amount, "INR");
      print("paymetnIntentClientSecret : $paymetnIntentClientSecret");
      if (paymetnIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymetnIntentClientSecret,
          merchantDisplayName: "AgriSync",
        ),
      );
      final bool paymentSatus = await _processPayment();
      payment = Payment(
        paymentId: "",
        amount: amount,
        status: paymentSatus ? "successful" : "failed",
        customerId: "",
        paymentIntentId: paymetnIntentClientSecret,
        orderId: '',
      );
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

  Future<bool> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      print("_processPayment : $e");
      return false;
    }
  }

  String _calculateAmount(double amt) {
    int calculatedAmount = (amt * 100).toInt();
    return calculatedAmount.toString();
  }
}
