import 'package:agrisync/screens/weather/weather_screen.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_mart_categories.dart';
import 'package:agrisync/widget/drawer_child.dart';
import 'package:agrisync/widget/thread_recommendation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/animted_toggle_button.dart';
import 'package:agrisync/widget/home_screen_technology.dart';
import 'package:agrisync/widget/crop_recommendation.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class AgriSyncHomeScreen extends StatefulWidget {
  const AgriSyncHomeScreen({super.key});

  @override
  State<AgriSyncHomeScreen> createState() => HomenScreenState();
}

class HomenScreenState extends State<AgriSyncHomeScreen> {
  bool _drawerOpen = false;

  @override
  void initState() {
    refreshUser();
    super.initState();
  }

  refreshUser() async {
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        // Theme.of(context).colorScheme.secondaryContainer,
        title: AgriSyncIcon(title: appLocalizations.agrisync),
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
          children: [
            const HomeScreenTechnology(),
            const SizedBox(height: 10),
            TextLato(
              text: appLocalizations.crop,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            const CropRecommendation(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const WeatherHomeScreen())),
                child: Card(
                  margin: const EdgeInsets.all(2),
                  elevation: 04,
                  child: ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset("assets/heavycloudy.png")),
                    title: TextLato(
                      text: appLocalizations.weather,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            TextLato(
              text: appLocalizations.agri_connect_update,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),

            const ThreadRecommendation(),
            TextLato(
              text: appLocalizations.agrimart,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),

            const AgriMartCategories(),
            // ThreadCard(),
            Card(
              elevation: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AgriSyncIcon(title: appLocalizations.agrisync),
                ],
              ),
            ),
            const SizedBox(
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
