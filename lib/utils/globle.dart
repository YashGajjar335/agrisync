import 'package:agrisync/screens/agritech_screen.dart';
import 'package:agrisync/screens/crop_detail_screen.dart';
import 'package:agrisync/screens/home_screen.dart';
import 'package:agrisync/screens/login_screen.dart';
import 'package:agrisync/shopping_page/shopping_page.dart';
import 'package:flutter/material.dart';

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;
String appLocalization = "package:flutter_gen/gen_l10n/app_localizations.dart";
String assets = "assets/";

List<Widget> tabItems = const [
  CropDetailScreen(crop: "ANY"),
  ShoppingScreen(),
  HomeScreen(),
  LoginScreen(),
  AgritechScreen(),
];
