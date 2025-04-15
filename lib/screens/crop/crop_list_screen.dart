import 'package:agrisync/model/crop_model.dart';
import 'package:agrisync/screens/crop/crop_detail_screen.dart';
import 'package:agrisync/widget/waiting_screen.dart';

import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CropListScreen extends StatefulWidget {
  final String cropcategories;
  final String cropCategoriesName;
  const CropListScreen(
      {super.key,
      required this.cropcategories,
      required this.cropCategoriesName});

  @override
  State<CropListScreen> createState() => _CropListScreenState();
}

class _CropListScreenState extends State<CropListScreen> {
  int appLanguage() {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    String appLang = appLocalizations.appLanguage;
    if (appLang == "en") {
      return 0;
    } else if (appLang == "hi") {
      return 1;
    } else if (appLang == "gu") {
      return 2;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int appLang = appLanguage();
    return Scaffold(
        appBar: AppBar(
          title: TextLato(
            text: widget.cropCategoriesName,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("crops")
              .where("category", isEqualTo: widget.cropcategories)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                int count = snapshot.data!.size;
                return count == 0
                    ? Center(
                        child: TextLato(
                          text: AppLocalizations.of(context)!.noCropAvi,
                        ),
                      )
                    : ListView.builder(
                        itemCount: count,
                        itemBuilder: (context, item) {
                          Crop crop = Crop.fromJson(snapshot.data!.docs[item]);
                          return Card(
                            child: ExpansionTile(
                              leading: crop.cropImage.isEmpty
                                  ? const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/farm.png'),
                                    )
                                  : StringImageInCircleAvatar(
                                      base64ImageString: crop.cropImage),
                              title: TextLato(text: crop.cropName[appLang]),
                              children: [
                                Card(
                                    margin: const EdgeInsets.all(16),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextLato(
                                        text: crop.description[appLang],
                                        textAlign: TextAlign.justify,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => CropDetailScreen(
                                                    crop: crop,
                                                    cropCatName: widget
                                                        .cropCategoriesName,
                                                  ))),
                                      child: TextLato(
                                        text: AppLocalizations.of(context)!
                                            .viewCropDetail,
                                      )),
                                )
                              ],
                            ),
                          );
                        });
              } else {
                return const WaitingScreenWithWarnning();
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WaitingScreen();
            }
            return const WaitingScreenWithWarnning();
          },
        ));
  }
}
