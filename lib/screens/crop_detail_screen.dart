import 'package:agrisync/screens/plant_health_reminder.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class CropDetailScreen extends StatefulWidget {
  final String crop;
  const CropDetailScreen({super.key, required this.crop});

  @override
  State<CropDetailScreen> createState() => _CropDetailScreenState();
}

class _CropDetailScreenState extends State<CropDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AgriSyncIcon(title: widget.crop),
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
                  child: Image.asset(
                    "assets/page11.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                child: TextLato(
                  text: widget.crop,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const InfoCrop(
                  title: "Growing Season:",
                  des: "Ideal planting time: October-November."),
              const InfoCrop(
                  title: "Climatic Conditions:",
                  des:
                      "Requires a cool climate during growth and a warm, dry climate during maturity."),
              const InfoCrop(title: "Temperature range: ", des: "10-25°C."),
              const InfoCrop(
                  title: "Rainfall requirement:",
                  des: "50-100 cm (requires well-drained soil)."),
              const InfoCrop(
                  title: "Soil Type:",
                  des:
                      "Loamy or clayey soil, rich in organic matter.\n   pH range: 6-7.5."),
              const InfoCrop(
                  title: "Fertilizers Required:",
                  des:
                      "Nitrogen: Urea \n    Phosphorus & Potash: DAP (Di-Ammonium Phosphate)"),
              const InfoCrop(
                  title: "Harvesting Time:",
                  des:
                      "Ready for harvest in 4-5 months after sowing (e.g., March-April)."),
              const InfoCrop(
                  title: "Common Diseases:",
                  des:
                      "Rust (yellow, brown, black),Powdery mildew,Smut diseases"),
              const InfoCrop(
                  title: "Yield:",
                  des: "With proper care: 3-4 tons per hectare (approx)"),
              const InfoCrop(
                  title: "Uses:",
                  des:
                      "Wheat is a staple grain used to make flour for bread, biscuits, and pasta.Bran is used as animal feed."),
              LongButton(
                  width: double.infinity,
                  name: "Start Plant Health Reminder",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlantHealthReminder(
                              cropSteps: [],
                              cropName: widget.crop,
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
