import 'package:agrisync/screens/crop/crop_list_screen.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class CropCard extends StatelessWidget {
  final String imagePath;
  final String cropCategoriesName;
  final Color color;
  final String cropCategories;
  const CropCard(
      {super.key,
      required this.imagePath,
      required this.cropCategoriesName,
      required this.color,
      required this.cropCategories});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CropListScreen(
                    cropcategories: cropCategories,
                    cropCategoriesName: cropCategoriesName,
                  ))),
      child: Card(
        elevation: 4,
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
                text: cropCategoriesName,
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
