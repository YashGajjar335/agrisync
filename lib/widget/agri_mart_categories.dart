import 'dart:convert';

import 'package:agrisync/screens/agri_mart/show_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

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
    "Seeds & Planting Material",
    "Fertilizers & Soil Enhancers",
    "Crop Protection (Pesticides, Biocontrol)",
    "Irrigation & Farm Machinery",
    "Tools & Equipment",
    "Animal & Aquaculture Products",
    "Greenhouse & Smart Farming Tech",
  ];

  @override
  Widget build(BuildContext context) {
    final cropCategories = List<String>.from(
        jsonDecode(AppLocalizations.of(context)!.cropCategories));

    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: SizedBox(
        height: 175,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: textField.length,
            itemBuilder: (context, index) {
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
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ShowProduct(
                                        categories: textField[index]))),
                            child: Image.asset(
                              'assets/crop_cat/${textField[index]}.jpeg',
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
                            cropCategories[index],
                            maxLines: 2,
                            style: GoogleFonts.lato(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
