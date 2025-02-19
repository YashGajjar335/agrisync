import 'package:agrisync/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AgriMartService {
  AgriMartService._();
  static final AgriMartService instance = AgriMartService._();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String collectionName = "Products";

  Future<String?> uploadProduct(
    String productName,
    String description,
    List<String> categories,
    double price,
    String unit,
    String productImage,
    int stockQuantity,
    DateTime createdAt,
    DateTime expireAt,
  ) async {
    try {
      String productId = const Uuid().v4();
      Products products = Products(
        productId: productId,
        productName: productName,
        description: description,
        categories: categories,
        price: price,
        unit: unit,
        stockQuantity: stockQuantity,
        productImageUrl: [productImage],
        createdAt: createdAt,
        expireAt: expireAt,
        averageRating: 0,
      );

      // status: stockQuantity == 0 ? "not-available" : "available",
      await _firebaseFirestore
          .collection(collectionName)
          .doc(productId)
          .set(products.toJson());
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
