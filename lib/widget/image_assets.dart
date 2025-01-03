import 'package:flutter/material.dart';

class ImageAssets extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  const ImageAssets(
      {super.key,
      required this.imagePath,
      this.height,
      this.width,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      color: color ?? Theme.of(context).colorScheme.primary,
      fit: BoxFit.fill,
      height: height ?? 25,
      width: width ?? 25,
    );
  }
}
