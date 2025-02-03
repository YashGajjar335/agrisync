import 'package:agrisync/model/cart_items.dart';
import 'package:flutter/material.dart';

class AgriMartCartScreen extends StatelessWidget {
  const AgriMartCartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff338864),
        centerTitle: true,
        title: Text(
          'My Cart',
          style: ThemeData().textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25,
              ),
        ),
      ),
      body: GestureDetector(
        onTap: () => {},
        child: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            CartItem cartItem = cart[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16, right: 10, left: 10),
              child: ListTile(
                leading: Image.asset(cartItem.product.image),
                title: Text(cartItem.product.title),
                subtitle: Text('Quantity:${cartItem.quantity}'),
                trailing:
                    Text('\$${cartItem.product.price * cartItem.quantity}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
