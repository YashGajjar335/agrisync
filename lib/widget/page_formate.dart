import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageFormate extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  const PageFormate(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 70, right: 30, left: 30, bottom: 50),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
            ),
          ),
        ),
        TextLato(
          text: title,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 6, 126, 70),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class CropPageFormate extends StatelessWidget {
  final String imageString;
  final String title;
  final String description;
  const CropPageFormate(
      {super.key,
      required this.imageString,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StringImage(
          height: height(context) * 0.3,
          width: width(context) * 0.8,
          base64ImageString: imageString,
          borderRadius: BorderRadius.circular(15),
        ),
        TextLato(
          text: title,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 6, 126, 70),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
