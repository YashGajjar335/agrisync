import 'package:flutter/material.dart';

class AgriTechCard extends StatefulWidget {
  const AgriTechCard({super.key});

  @override
  State<AgriTechCard> createState() => _AgriTechCardState();
}

class _AgriTechCardState extends State<AgriTechCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Positioned(
              child: Image.asset(
            "assets/cal1.jpg",
            fit: BoxFit.fill,
          )),
        ],
      ),
    );
  }
}
