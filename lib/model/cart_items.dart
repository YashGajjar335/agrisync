import 'package:agrisync/model/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

List<CartItem> cart = [];
