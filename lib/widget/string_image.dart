import 'dart:typed_data';
import 'package:agrisync/utils/globle.dart';
import 'package:flutter/material.dart';

class StringImage extends StatefulWidget {
  final String base64ImageString;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final bool? defaultHeight;
  final bool? defaultwidth;
  final BorderRadius? borderRadius;

  const StringImage({
    super.key,
    required this.base64ImageString,
    this.fit,
    this.width,
    this.height,
    this.borderRadius,
    this.defaultHeight = false,
    this.defaultwidth = false,
  });

  @override
  State<StringImage> createState() => _StringImageState();
}

class _StringImageState extends State<StringImage> {
  Uint8List? photoImageData;

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (photoImageData != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        child: Image.memory(
          photoImageData!,
          fit: widget.fit ?? BoxFit.contain,
          height: widget.height ?? 500,
          width: widget.width ?? 200,
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  void loadImage() async {
    final data = await base64StringToImage(widget.base64ImageString);
    photoImageData = data;
    setState(() {});
  }
}
