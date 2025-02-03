import 'package:agrisync/model/cart_items.dart';
import 'package:agrisync/model/order.dart';
import 'package:agrisync/model/product.dart';
import 'package:agrisync/model/user_address.dart';
import 'package:agrisync/screens/product_order_screen.dart';
import 'package:flutter/material.dart';

class AddToCartBuyButton extends StatelessWidget {
  const AddToCartBuyButton({
    super.key,
    required this.product,
  });

  final Product product;
  @override
  Widget build(BuildContext context) {
    UserAddress address = UserAddress(
      street: '123 Main St',
      city: 'Springfield',
      state: 'IL',
      postalCode: '62701',
    );

    Order order = Order(
      product: product,
      quantity: 2,
      paymentStatus: false,
      shippingAddress: address,
    );

    void addToCart(Product product) {
      CartItem? existingCartItem = cart.firstWhere(
        (cartItem) => cartItem.product.id == product.id,
        orElse: () => CartItem(product: product, quantity: 0),
      );

      if (existingCartItem.quantity > 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${product.title} already in Cart'),
          duration: const Duration(
            seconds: 1,
          ),
        ));
      } else {
        cart.add(CartItem(product: product));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: product.color)),
            child: IconButton(
              onPressed: () {
                addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${product.title} added to cart'),
                  duration: const Duration(
                    seconds: 1,
                  ),
                ));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          Expanded(
            child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                        0xff338864,
                      )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductOrderScreen(
                                    order: order,
                                  )),
                        );
                      },
                      child: Text(
                        'Buy Now'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
