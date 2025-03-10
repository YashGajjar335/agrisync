import 'package:agrisync/screens/crop/crop_list_screen.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class CropRecommendation extends StatefulWidget {
  const CropRecommendation({super.key});

  @override
  State<CropRecommendation> createState() => _CropRecommendationState();
}

class _CropRecommendationState extends State<CropRecommendation> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 4,
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
              String catName;
              String name;
              String imageName;
              index == 0
                  ? {
                      name = "Kharif",
                      catName = appLocalizations.kharif,
                      imageName = "kharif"
                    }
                  : index == 1
                      ? {
                          name = "Rabi",
                          catName = appLocalizations.rabi,
                          imageName = "rabi"
                        }
                      : {
                          name = "Zaid",
                          catName = appLocalizations.zaid,
                          imageName = "zaid"
                        };
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: CropListScreen(
                        cropcategories: name,
                        cropCategoriesName: catName,
                      ),
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
                              'assets/$imageName.png',
                              fit: BoxFit.cover,
                              // height: height(context) * 0.1,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Text(
                          catName,
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
      ),
    );
  }
}
