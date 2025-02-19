import 'package:agrisync/screens/crop/crop_list_screen.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class CropCard extends StatelessWidget {
  final String imagePath;
  final String cropName;
  final Color color;
  const CropCard(
      {super.key,
      required this.imagePath,
      required this.cropName,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CropListScreen(crop: cropName))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fill,
                  )),
            ),
            TextLato(
              text: cropName,
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: color,
            )
          ],
        ),
      ),
    );
  }
}
