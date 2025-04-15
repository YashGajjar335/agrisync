import 'package:agrisync/model/crop_model.dart';
import 'package:agrisync/screens/crop/plant_health_reminder.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class CropDetailScreen extends StatefulWidget {
  final Crop crop;
  final String cropCatName;
  const CropDetailScreen(
      {super.key, required this.crop, required this.cropCatName});

  @override
  State<CropDetailScreen> createState() => _CropDetailScreenState();
}

class _CropDetailScreenState extends State<CropDetailScreen> {
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

  String cropcategories = "zaid";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    int stepCount = widget.crop.language[appLocalizations.appLanguage]!.length;

    int appLang = appLanguage();
    return Scaffold(
      appBar: AppBar(
        title: AgriSyncIcon(title: widget.crop.cropName[appLang]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.crop.cropImage.isNotEmpty
                      ? StringImage(
                          base64ImageString: widget.crop.cropImage,
                          height: height(context) * 0.3,
                          width: width(context) * 0.9,
                        )
                      : Image.asset(
                          "assets/page11.png",
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              Center(
                child: TextLato(
                  text: widget.cropCatName,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stepCount,
                  itemBuilder: (context, item) {
                    final step =
                        widget.crop.language[appLocalizations.appLanguage];
                    return InfoCrop(
                        title: step![item].title, des: step![item].description);
                  }),
              LongButton(
                  width: double.infinity,
                  buttonText:
                      "${appLocalizations.crophealthreminder} ${appLocalizations.getStart}",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlantHealthReminder(
                              cropSteps: widget.crop
                                      .language[appLocalizations.appLanguage] ??
                                  [],
                              cropName: widget.crop.cropName[appLang],
                              cropImage: widget.crop.images,
                            )));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCrop extends StatelessWidget {
  final String title;
  final String des;
  const InfoCrop({super.key, required this.title, required this.des});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextLato(
              text: title,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            TextLato(
              text: "    $des",
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
