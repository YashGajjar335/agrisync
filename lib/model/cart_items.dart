import 'package:cloud_firestore/cloud_firestore.dart';

class CartItems {
  final String cartId;
  final String userId;
  final Map<String, int> products; // Maps productId to quantity

  CartItems({
    required this.cartId,
    required this.userId,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      "cartId": cartId,
      "userId": userId,
      "products": products, // Firestore stores Maps directly
    };
  }

  static CartItems fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data() as Map<String, dynamic>;
    return CartItems(
      cartId: map['cartId'] ?? "",
      userId: map['userId'] ?? "",
      products: Map<String, int>.from(map['products'] ?? {}),
    );
  }
}
