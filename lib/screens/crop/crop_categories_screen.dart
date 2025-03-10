import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/crop_card.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class CropCategoriesScreen extends StatefulWidget {
  const CropCategoriesScreen({super.key});

  @override
  State<CropCategoriesScreen> createState() => _CropCategoriesScreenState();
}

class _CropCategoriesScreenState extends State<CropCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: AgriSyncIcon(title: appLocalizations.crop),
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
