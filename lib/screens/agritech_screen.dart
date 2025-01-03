import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class AgritechScreen extends StatelessWidget {
  const AgritechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextLato(text: "Technology Page"),
      ),
    );
  }
}
