import 'dart:typed_data';
import 'package:agrisync/utils/globle.dart';
import 'package:flutter/material.dart';

class StringImageInCircleAvatar extends StatefulWidget {
  final String base64ImageString;
  final double? radius;

  const StringImageInCircleAvatar({
    super.key,
    required this.base64ImageString,
    this.radius,
  });

  @override
  State<StringImageInCircleAvatar> createState() =>
      _StringImageInCircleAvatarState();
}

class _StringImageInCircleAvatarState extends State<StringImageInCircleAvatar> {
  Uint8List? photoImageData;

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return photoImageData == null
        ? const CircularProgressIndicator()
        : CircleAvatar(
            radius: widget.radius ?? 23,
            backgroundImage: MemoryImage(photoImageData!));
  }

  loadImage() async {
    photoImageData = await base64StringToImage(widget.base64ImageString);
    setState(() {});
  }
}
