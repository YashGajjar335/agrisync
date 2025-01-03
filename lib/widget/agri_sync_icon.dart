import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgriSyncIcon extends StatelessWidget {
  final String title;
  const AgriSyncIcon({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: AssetImage('assets/app_logo_half.JPG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          title,
          style: GoogleFonts.lato(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
      ],
    );
  }
}
