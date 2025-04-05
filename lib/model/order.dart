import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String orderId;
  String userId;
  Map<String, int> items;
  double totalAmount;
  // String paymentMethod; // e.g., "Credit Card", "UPI", "Cash on Delivery"
  String orderStatus; // e.g., "Pending", "Shipped", "Delivered", "Cancelled"
  DateTime orderDate;
  DateTime? deliveryDate;
  DateTime? shippingDate;
  String addressId; // Reference to UserAddress
  String transactionId; // Payment transaction ID (if applicable)

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.totalAmount,
    // required this.paymentMethod,
    required this.orderStatus,
    required this.orderDate,
    this.deliveryDate,
    this.shippingDate,
    required this.addressId,
    required this.transactionId,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'items': items,
      'totalAmount': totalAmount,
      // // 'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'orderDate': orderDate,
      'deliveryDate':
          deliveryDate != null ? Timestamp.fromDate(deliveryDate!) : null,
      'shippingDate':
          shippingDate != null ? Timestamp.fromDate(shippingDate!) : null,
      'addressId': addressId,
      'transactionId': transactionId,
    };
  }

  // Create an Order object from a Firestore DocumentSnapshot
  static OrderModel fromSnap(DocumentSnapshot doc) {
    if (!doc.exists) {
      throw Exception("Order document does not exist");
    }

    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    return OrderModel(
      orderId: doc.id, // Use Firestore document ID as orderId
      userId: map['userId'] ?? '',
      items: (map['items'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, (value as num).toInt()),
          ) ??
          {},
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      // paymentMethod: map['paymentMethod'] ?? '',
      orderStatus: map['orderStatus'] ?? 'Pending',
      orderDate: (map['orderDate'] as Timestamp).toDate(),
      deliveryDate: map['deliveryDate'] != null
          ? (map['deliveryDate'] as Timestamp).toDate()
          : null,
      shippingDate: map['shippingDate'] != null
          ? (map['shippingDate'] as Timestamp).toDate()
          : null,
      addressId: map['addressId'] ?? '',
      transactionId: map['transactionId'] ?? '',
    );
  }
}
