import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String orderId;
  String userId;
  Map<String, int> items;
  double totalAmount;
  String paymentMethod; // e.g., "Credit Card", "UPI", "Cash on Delivery"
  String orderStatus; // e.g., "Pending", "Shipped", "Delivered", "Cancelled"
  DateTime orderDate;
  DateTime? deliveryDate;
  String addressId; // Reference to UserAddress
  String transactionId; // Payment transaction ID (if applicable)

  Order({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.orderStatus,
    required this.orderDate,
    this.deliveryDate,
    required this.addressId,
    required this.transactionId,
  });

  // Convert Order object to a Map (for Firebase/DB storage)
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'items': items, // This is already a Map<String, int>
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'addressId': addressId,
      'transactionId': transactionId,
    };
  }

  // Create an Order object from a Firestore DocumentSnapshot
  static Order fromMap(DocumentSnapshot doc) {
    if (!doc.exists) {
      throw Exception("Order document does not exist");
    }

    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    return Order(
      orderId: doc.id, // Use Firestore document ID as orderId
      userId: map['userId'] ?? '',
      items: (map['items'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, (value as num).toInt()),
          ) ??
          {},
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      paymentMethod: map['paymentMethod'] ?? '',
      orderStatus: map['orderStatus'] ?? 'Pending',
      orderDate: DateTime.parse(map['orderDate']),
      deliveryDate: map['deliveryDate'] != null
          ? DateTime.parse(map['deliveryDate'])
          : null,
      addressId: map['addressId'] ?? '',
      transactionId: map['transactionId'] ?? '',
    );
  }
}
