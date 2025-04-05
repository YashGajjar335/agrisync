import 'package:agrisync/model/cart_items.dart';
import 'package:agrisync/model/payment.dart';
import 'package:agrisync/model/product.dart';
import 'package:agrisync/model/product_review.dart';
import 'package:agrisync/model/user_address.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:agrisync/model/order.dart';

class AgriMartServiceUser {
  AgriMartServiceUser._();
  static AgriMartServiceUser instance = AgriMartServiceUser._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<Products?> getProduct(String productId) async {
    try {
      final snap =
          await _firestore.collection(productCollection).doc(productId).get();
      return Products.fromSnap(snap);
    } catch (e) {
      print("ERROR getProduct : ${e.toString()}");
      return null;
    }
  }

  Future<UserAddress?> getUserAddress() async {
    try {
      final snap = await _firestore
          .collection("Address")
          .where('userId', isEqualTo: uid)
          .get();
      if (snap.docs.first.exists) {
        UserAddress userAddress = UserAddress.fromSnap(snap.docs.first);
        return userAddress;
      } else {
        return null;
      }
    } catch (e) {
      print("ERROR agriMartService : getUserAdress : ${e.toString()}");
      return null;
    }
  }

  Future<List<Products>> getAllProductName() async {
    try {
      final productdata = await _firestore.collection(productCollection).get();
      return productdata.docs.map(Products.fromSnap).toList();
    } catch (e) {
      print("ERROR TO GET PRODUCT NAME LIST : ${e.toString()}");
      return [];
    }
  }

  Future<String?> updateUserAddress(
      String fullName,
      String phoneNumber,
      String flatNumber,
      String streetRoad,
      String street,
      String city,
      String state,
      String country,
      String postalCode) async {
    try {
      final querySnapshot = await _firestore
          .collection("Address")
          .where("userId", isEqualTo: uid)
          .limit(1)
          .get();

      String id = querySnapshot.docs.isNotEmpty
          ? querySnapshot.docs.first.id
          : const Uuid().v4();

      UserAddress address = UserAddress(
        id: id,
        userId: uid,
        fullName: fullName,
        phoneNumber: phoneNumber,
        flatNumber: flatNumber,
        streetRoad: streetRoad,
        street: street,
        city: city,
        state: state,
        country: country,
        postalCode: postalCode,
      );

      await _firestore
          .collection("Address")
          .doc(id)
          .set(address.toMap(), SetOptions(merge: true));

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> uploadProductReview(
      String productId, String review, double rating) async {
    try {
      final String reviewId = const Uuid().v4();
      ProductReview productReview = ProductReview(
          productId: productId, uid: uid, review: review, rating: rating);
      await _firestore
          .collection(productCollection)
          .doc(productId)
          .collection(reviewCollection)
          .doc(reviewId)
          .set(productReview.toJson());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> addToCart(
    String productId,
  ) async {
    try {
      final DocumentReference documentReference =
          _firestore.collection("userCart").doc(uid);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      if (documentSnapshot.exists) {
        // Fetch the existing cart
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        Map<String, int> products =
            Map<String, int>.from(data?["products"] ?? {});

        // Update quantity if the product already exists
        if (products.containsKey(productId)) {
          products[productId] = products[productId]! + 1;
        } else {
          products[productId] = 1;
        }

        await documentReference.update({"products": products});
      } else {
        // Create a new cart entry with the first product
        CartItems cart =
            CartItems(cartId: uid, userId: uid, products: {productId: 1});
        await documentReference.set(cart.toJson());
      }

      return "Product added to cart successfully";
    } catch (e) {
      print("Error adding to cart: $e");
      return "Failed to add product to cart";
    }
  }

  Future<String?> confirmOrder(
    Payment p,
    Map<String, int> items,
    double totalAmount,
    String addressId,
  ) async {
    try {
      String orderId = const Uuid().v4();
      String paymentId = const Uuid().v4();

      Payment payment = Payment(
          paymentId: paymentId,
          amount: p.amount,
          status: p.status,
          customerId: uid,
          orderId: orderId,
          paymentIntentId: p.paymentIntentId);

      await _firestore
          .collection(paymentCollection)
          .doc(payment.paymentId)
          .set(payment.toJson());

      OrderModel orderModel = OrderModel(
        orderId: orderId,
        userId: uid,
        items: items,
        totalAmount: totalAmount,
        orderStatus: "pending",
        orderDate: DateTime.now(),
        addressId: addressId,
        transactionId: payment.paymentId,
      );

      orderModel.items.forEach((productId, quantity) async {
        Products? products = await getProduct(productId);
        if (products != null) {
          await _firestore
              .collection(productCollection)
              .doc(productId)
              .update({"stockQuantity": products.stockQuantity -= quantity});
        }
      });

      await _firestore
          .collection(orderCollection)
          .doc(orderId)
          .set(orderModel.toMap());
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
