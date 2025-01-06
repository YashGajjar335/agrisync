import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLato extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? paddingAll;
  const TextLato(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontColor,
      this.fontWeight,
      this.paddingAll});

  @override
  Widget build(BuildContext context) {
    double padding = paddingAll ?? 0.8;
    return Padding(
      padding: EdgeInsets.all(padding),
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
