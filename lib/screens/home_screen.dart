import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/widget/drawer_child.dart';
import 'package:agrisync/widget/flashy_bottom_navigation_bar.dart';
import 'package:agrisync/widget/weather_card.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/animted_toggle_button.dart';
import 'package:agrisync/widget/home_screen_technology.dart';
import 'package:agrisync/widget/crop_recommendation.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomenScreenState();
}

class HomenScreenState extends State<HomeScreen> {
  bool _drawerOpen = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        // Theme.of(context).colorScheme.secondaryContainer,
        title: AgriSyncIcon(title: localizations.agrisync),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Builder(
              builder: (context) => IconButton(
                icon: AnimatedToggleButton(
                  currIndex: _drawerOpen,
                  icon1: const Icon(Icons.close),
                  icon2: Image.asset(
                    AgrisyncImageIcon().home,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                  // Navigator.of(context).push(PageAnimationTransition(
                  //     page: const ChangeLangScreen(),
                  //     pageAnimationType: FadeAnimationTransition()));
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            HomeScreenTechnology(),
            SizedBox(height: 10),
            TextLato(
              text: "Crop Information",
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            CropRecommendation(),
            TextLato(
              text: "Weather",
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            WeatherCard(),
            TextLato(
              text: "Today's Communication",
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            HomeScreenTechnology(),
            TextLato(
              text: "Today's MarketView",
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            CropRecommendation(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AgriSyncIcon(title: "AgriSync"),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: const DrawerChild(),
      ),
      bottomNavigationBar: FlashyBottomNavigationBar(),
      onDrawerChanged: (isOpen) {
        // print("Drawer is : $isOpen");
        setState(() {
          _drawerOpen = isOpen;
        });
      },
    );
  }
}
