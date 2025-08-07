import 'package:agrisync/model/crop_health_reminder.dart';
import 'package:agrisync/model/crop_model.dart';
import 'package:agrisync/screens/crop/plant_health_reminder.dart';
import 'package:agrisync/services/crop_health_reminder_services.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/crop_card.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/waiting_screen.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class CropCategoriesScreen extends StatefulWidget {
  const CropCategoriesScreen({super.key});

  @override
  State<CropCategoriesScreen> createState() => _CropCategoriesScreenState();
}

class _CropCategoriesScreenState extends State<CropCategoriesScreen> {
  int appLanguage() {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    String appLanguage = appLocalizations.appLanguage;
    if (appLanguage == "en") {
      return 0;
    } else if (appLanguage == "hi") {
      return 1;
    } else if (appLanguage == "gu") {
      return 2;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: AgriSyncIcon(title: appLocalizations.crop),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: FutureBuilder(
            future:
                CropHealthReminderServices.instance.userCropHealthReminder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const WaitingScreen();
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, item) {
                        Crop crop = snapshot.data![item];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PlantHealthReminderScreen(
                                          cropSteps: crop.language[
                                                  appLocalizations
                                                      .appLanguage] ??
                                              [],
                                          cropName:
                                              crop.cropName[appLanguage()],
                                          cropImage: crop.images,
                                        ))),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: SizedBox(
                                  height: 90,
                                  width: 60,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      StringImageInCircleAvatar(
                                          radius: 30,
                                          base64ImageString: crop.cropImage),
                                      TextLato(
                                        text: crop.cropName[appLanguage()],
                                        maxLine: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const WaitingScreenWithWarnning();
                }
              }
              return const WaitingScreenWithWarnning();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CropCard(
              imagePath: "assets/kharif.png",
              cropCategoriesName: appLocalizations.kharif,
              color: Colors.white,
              cropCategories: 'Kharif',
            ),
            CropCard(
              imagePath: "assets/zaid.png",
              cropCategoriesName: appLocalizations.zaid,
              color: Colors.white,
              cropCategories: 'Zaid',
            ),
            CropCard(
              imagePath: "assets/rabi.png",
              cropCategoriesName: appLocalizations.rabi,
              color: Colors.white,
              cropCategories: 'Rabi',
            ),
          ],
        ),
      ),
    );
  }
}
