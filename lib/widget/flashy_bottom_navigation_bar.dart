import 'package:agrisync/screens/agritech_screen.dart';
import 'package:agrisync/screens/crop_detail_screen.dart';
import 'package:agrisync/screens/home_screen.dart';
import 'package:agrisync/screens/login_screen.dart';
import 'package:agrisync/shopping_page/shopping_page.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/widget/image_assets.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class FlashyBottomNavigationBar extends StatefulWidget {
  const FlashyBottomNavigationBar({super.key});

  @override
  State<FlashyBottomNavigationBar> createState() =>
      _FlashyBottomNavigationBarState();
}

class _FlashyBottomNavigationBarState extends State<FlashyBottomNavigationBar> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    List<Widget> tabItems = const [
      CropDetailScreen(crop: "ANY"),
      ShoppingPage(),
      HomeScreen(),
      LoginScreen(),
      AgritechScreen(),
    ];
    return FlashyTabBar(
      animationCurve: Curves.linear,
      selectedIndex: _selectedIndex,
      height: 70,
      iconSize: 30,
      backgroundColor: Colors.transparent,
      showElevation: false, // use this to remove appBar's elevation
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => tabItems[index]));
        print(_selectedIndex);
      }),
      items: [
        FlashyTabBarItem(
          icon: ImageAssets(imagePath: AgrisyncImageIcon().cropHealthReminder),
          title: const TextLato(text: "Crop"),
        ),
        FlashyTabBarItem(
          icon: ImageAssets(
            imagePath: AgrisyncImageIcon().shoppingCart,
          ),
          title: const TextLato(text: "AgriMart"),
        ),
        FlashyTabBarItem(
          icon: ImageAssets(
            imagePath: AgrisyncImageIcon().home,
          ),
          title: const TextLato(text: "Home"),
        ),
        FlashyTabBarItem(
          icon: ImageAssets(
            imagePath: AgrisyncImageIcon().socialPage,
          ),
          title: const TextLato(
            text: "Thread",
            fontSize: 15,
          ),
        ),
        FlashyTabBarItem(
          icon: ImageAssets(
            imagePath: AgrisyncImageIcon().technology,
          ),
          title: const TextLato(
            text: "AgriTech",
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
