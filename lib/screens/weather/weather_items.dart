import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  final String value;
  final String unit;
  final String imageUrl;

  const WeatherItem({
    super.key,
    required this.value,
    required this.unit,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          value + unit,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
