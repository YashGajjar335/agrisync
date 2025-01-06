import 'package:agrisync/screens/agritech_screen.dart';
import 'package:agrisync/screens/crop_list_screen.dart';
import 'package:agrisync/screens/home_screen.dart';
import 'package:agrisync/screens/login_screen.dart';
import 'package:agrisync/shopping_page/agri_mart_screen.dart';
import 'package:flutter/material.dart';

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;
String appLocalization = "package:flutter_gen/gen_l10n/app_localizations.dart";
String assets = "assets/";

List<Widget> tabItems = const [
  CropListScreen(crop: "ANY"),
  AgriMartScreen(),
  HomeScreen(),
  LoginScreen(),
  AgritechScreen(),
];
