import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/crop_card.dart';
import 'package:flutter/material.dart';

class CropCategoriesScreen extends StatefulWidget {
  const CropCategoriesScreen({super.key});

  @override
  State<CropCategoriesScreen> createState() => _CropCategoriesScreenState();
}

class _CropCategoriesScreenState extends State<CropCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "Crop"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CropCard(
              imagePath: "assets/farm.png",
              cropName: "Khrif",
              color: Colors.white,
            ),
            CropCard(
              imagePath: "assets/farm.png",
              cropName: "Zaid",
              color: Colors.white,
            ),
            CropCard(
              imagePath: "assets/farm.png",
              cropName: "Rabi",
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
