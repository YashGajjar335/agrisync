import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLato extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  const TextLato(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontColor,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: GoogleFonts.lato(
          color: fontColor ?? Theme.of(context).colorScheme.secondary,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? 16,
        ),
      ),
    );
  }
}
