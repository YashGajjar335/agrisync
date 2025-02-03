import 'package:agrisync/model/order.dart';
import 'package:agrisync/widget/add_address.dart';
import 'package:agrisync/widget/make_payment.dart';
import 'package:flutter/material.dart';

class ProductOrderScreen extends StatefulWidget {
  final Order order;
  const ProductOrderScreen({super.key, required this.order});

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff338864),
        title: Text(
          'Order Details',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            SizedBox(
              height: 260,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 16, right: 10, left: 10),
                child: ListTile(
                  leading: const Text('Image'),
                  title: Text(widget.order.product.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(widget.order.product.description,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  trailing: Text('\$${widget.order.totalAmount}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 16, left: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shipping Address',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Container(
                              margin: const EdgeInsets.only(right: 12),
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: Colors.grey)),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddAddress()));
                                  },
                                  child: const Text(
                                    'Chnage',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Street: ${widget.order.shippingAddress.street}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                          Text('City: ${widget.order.shippingAddress.city}',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black87)),
                          Text('State: ${widget.order.shippingAddress.state}',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black87)),
                          Text(
                              'Postal Code: ${widget.order.shippingAddress.postalCode}',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 16, right: 10, left: 10),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MakePayment(),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order Confirmed')));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color(0xff338864),
                ),
                child: const Text(
                  'Confirm Order',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
