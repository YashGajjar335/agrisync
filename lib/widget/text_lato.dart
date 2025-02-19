import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLato extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final double? paddingAll;
  final int? maxLine;
  const TextLato(
      {super.key,
      required this.text,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.paddingAll,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    double padding = paddingAll ?? 0.8;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        maxLines: maxLine,
        text,
        style: GoogleFonts.lato(
          color: color ?? Theme.of(context).colorScheme.secondary,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? 16,
        ),
      ),
    );
  }
}
