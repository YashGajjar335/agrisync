import 'dart:typed_data';

import 'package:agrisync/utils/globle.dart';
import 'package:flutter/material.dart';

class StringImage extends StatelessWidget {
  final String base64ImageString;

  const StringImage({super.key, required this.base64ImageString});

  @override
  Widget build(BuildContext context) {
    Uint8List memoryImage = loadImage();
    return memoryImage == null
        ? CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          )
        : Image.memory(memoryImage);
  }

  loadImage() async {
    return await base64StringToImage(base64ImageString);
  }
}
