import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/flashy_bottom_navigation_bar.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class AgritechScreen extends StatelessWidget {
  const AgritechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(title: "AgriTech"),
      ),
      body: const Center(
        child: TextLato(text: "Technology Page"),
      ),
      bottomNavigationBar: const FlashyBottomNavigationBar(),
    );
  }
}
