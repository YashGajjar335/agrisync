import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgriMartCategories extends StatefulWidget {
  const AgriMartCategories({super.key});

  @override
  State<AgriMartCategories> createState() => _AgriMartCategoriesState();
}

class _AgriMartCategoriesState extends State<AgriMartCategories> {
  final List<String> images = [
    'assets/farm.png',
    'assets/farm.png',
    'assets/farm.png',
    'assets/farm.png',
    'assets/farm.png',
    'assets/farm.png',
  ];

  final List<String> textField = [
    'Fertilizer',
    'Pesticides',
    'Seeds',
    'Equipment',
    'Pesticides',
    'Fertilizer'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index) {
            return ClipRect(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 10, bottom: 10, right: 10, top: 10),
                width: 110, // Set width as per requirement
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image in ClipRect
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: GestureDetector(
                          onTap: () {
                            print('Image is cliable');
                          },
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.fill,
                            height: 100,
                            width: 100,
                          )),
                    ),
                    const SizedBox(
                        height: 5), // Space between image and text field
                    // TextField in ClipRect
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          textField[index],
                          style: GoogleFonts.lato(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
