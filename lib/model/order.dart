import 'package:agrisync/model/product.dart';
import 'package:agrisync/model/user_address.dart';

class Order {
  final Product product;
  final int quantity;
  final UserAddress shippingAddress;
  final bool paymentStatus;

  double get totalAmount => product.price * quantity.toDouble();

  Order({
    required this.product,
    required this.quantity,
    required this.shippingAddress,
    required this.paymentStatus,
  });
}
