import 'package:agrisync/screens/agritech_screen.dart';
import 'package:agrisync/screens/crop_detail_screen.dart';
import 'package:agrisync/screens/home_screen.dart';
import 'package:agrisync/screens/login_screen.dart';
import 'package:agrisync/shopping_page/shopping_page.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = GoogleFonts.lato(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold);
    List<Widget> tabItems = const [
      CropDetailScreen(crop: "ANY"),
      ShoppingScreen(),
      HomeScreen(),
      LoginScreen(),
      AgritechScreen(),
    ];
    return Scaffold(
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
            label: "Crop",
            labelStyle: labelStyle,
          ),
          CurvedNavigationBarItem(
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().shoppingCart,
            ),
            label: "AgriMart",
            labelStyle: labelStyle,
          ),
          CurvedNavigationBarItem(
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().home,
            ),
            label: "Home",
            labelStyle: labelStyle,
          ),
          CurvedNavigationBarItem(
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().socialPage,
            ),
            label: "AgriConnect",
            labelStyle: labelStyle,
          ),
          CurvedNavigationBarItem(
            child: ImageAssets(
              imagePath: AgrisyncImageIcon().technology,
            ),
            label: "AgriTech",
            labelStyle: labelStyle,
          ),
        ],
      ),
    );
  }
}
