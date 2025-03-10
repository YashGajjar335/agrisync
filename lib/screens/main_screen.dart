import 'package:agrisync/screens/agriConnect/agri_connect_screen.dart';
import 'package:agrisync/screens/agri_tech/agri_tech_screen.dart';
import 'package:agrisync/screens/crop/crop_categories_screen.dart';
import 'package:agrisync/screens/agri_sync_home_screen.dart';
import 'package:agrisync/screens/agri_mart/agri_mart_screen.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/widget/drawer_child.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  final int? initPage;
  const MainScreen({super.key, this.initPage});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;

  @override
  void initState() {
    _selectedIndex = widget.initPage ?? 2;
    super.initState();
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalization = AppLocalizations.of(context)!;

    TextStyle labelStyle = GoogleFonts.lato(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold);

    List<Widget> tabItems = const [
      CropCategoriesScreen(),
      AgriMartScreen(),
      AgriSyncHomeScreen(),
      AgriConnectScreen(),
      AgriTechScreen(),
    ];

    return Scaffold(
      // key: _scaffoldKey,
      extendBody: true,
      body: tabItems[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.secondaryContainer,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
        index: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          CurvedNavigationBarItem(
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().cropHealthReminder,
              height: 20,
              width: 20,
            ),
            label: appLocalization.crop,
            labelStyle: labelStyle,
          ),
          CurvedNavigationBarItem(
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().shoppingCart,
            ),
            label: appLocalization.agrimart,
            labelStyle: labelStyle,
          ),
          CurvedNavigationBarItem(
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().home,
            ),
            label: appLocalization.home,
            labelStyle: labelStyle,
          ),
          CurvedNavigationBarItem(
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().socialPage,
            ),
            label: appLocalization.agriconnect,
            labelStyle: labelStyle,
          ),
          CurvedNavigationBarItem(
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().technology,
            ),
            label: appLocalization.agritech,
            labelStyle: labelStyle,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: const DrawerChild(),
      ),
    );
  }
}
