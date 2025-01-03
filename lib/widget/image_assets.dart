import 'package:flutter/material.dart';

class ImageAssets extends StatelessWidget {
  final String imagePath;
  const ImageAssets({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.asset(
        imagePath,
        color: Theme.of(context).colorScheme.primary,
        height: 20,
        width: 20,
        fit: BoxFit.cover,
      ),
    );
  }
}
