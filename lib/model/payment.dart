import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  final String paymentId;
  final String orderId;
  final double amount;
  final String status;
  final String customerId;
  final String paymentIntentId;

  Payment({
    required this.paymentId,
    required this.amount,
    required this.status,
    required this.customerId,
    required this.orderId,
    required this.paymentIntentId,
  });

  Map<String, dynamic> toJson() {
    return {
      "paymentId": paymentId,
      "amount": amount,
      "status": status,
      "customerId": customerId,
      "paymentIntentId": paymentIntentId,
      "orderId": orderId,
    };
  }

  static Payment fromJson(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;
    return Payment(
        paymentId: map['paymentId'] ?? "",
        amount: map['amount'] ?? 0.000,
        status: map['status'] ?? "",
        customerId: map['customerId'] ?? "",
        paymentIntentId: map['paymentIntentId'] ?? "",
        orderId: map['orderId'] ?? "");
  }
}
