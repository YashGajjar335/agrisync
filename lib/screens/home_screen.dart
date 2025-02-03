import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/widget/agri_mart_categories.dart';
import 'package:agrisync/widget/drawer_child.dart';
import 'package:agrisync/widget/thread_recommendation.dart';
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
    final primary = Theme.of(context).colorScheme.primary;
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
                  icon1: Icon(
                    Icons.close,
                    color: primary,
                  ),
                  icon2: Image.asset(
                    AgrisyncImageIcon().more,
                    color: primary,
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: const [
            HomeScreenTechnology(),
            SizedBox(height: 10),
            TextLato(
              text: "Crop ",
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
              text: "AgriConnect Update",
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),

            ThreadRecommendation(),
            TextLato(
              text: "AgriMart",
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),

            AgriMartCategories(),
            // ThreadCard(),
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
      onDrawerChanged: (isOpen) {
        // print("Drawer is : $isOpen");
        setState(() {
          _drawerOpen = isOpen;
        });
      },
    );
  }
}
