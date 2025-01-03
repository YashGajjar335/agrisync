import 'package:agrisync/screens/crop_detail_screen.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class CropRecommendation extends StatefulWidget {
  const CropRecommendation({super.key});

  @override
  State<CropRecommendation> createState() => _CropRecommendationState();
}

class _CropRecommendationState extends State<CropRecommendation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: width(context) * 0.32,
        // width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1.0),
          itemCount: 3,
          itemBuilder: (context, index) {
            String name;
            index == 1
                ? name = "kharif"
                : index == 2
                    ? name = "Rabi"
                    : name = "zaid";
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(PageAnimationTransition(
                    page: CropDetailScreen(crop: name),
                    pageAnimationType: FadeAnimationTransition()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  // color: Colors.red,
                  // height: height(context) * 0.13,
                  width: width(context) * 0.33,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/farm.png',
                            fit: BoxFit.cover,
                            // height: height(context) * 0.1,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Text(
                        name,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
