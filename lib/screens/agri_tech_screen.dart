// import 'package:agrisync/screens/payment_screen.dart';
// import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/agri_tech_card.dart';
import 'package:flutter/material.dart';

class AgriTechScreen extends StatelessWidget {
  const AgriTechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "AgriTech"),
      ),
      body: const Center(
        child: AgriTechCard(),
      ),
    );
  }
}
