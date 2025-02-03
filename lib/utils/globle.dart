import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agrisync/screens/agri_tech_screen.dart';
import 'package:agrisync/screens/crop_list_screen.dart';
import 'package:agrisync/screens/home_screen.dart';
import 'package:agrisync/screens/auth/login_screen.dart';
import 'package:agrisync/screens/agri_mart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;
String appLocalization = "package:flutter_gen/gen_l10n/app_localizations.dart";
String assets = "assets/";
List<Widget> tabItems = const [
  CropListScreen(crop: "ANY"),
  AgriMartScreen(),
  HomeScreen(),
  LoginScreen(),
  AgriTechScreen(),
];

Future<String?> pickImageAndConvertToBase64() async {
  try {
    final picker = ImagePicker();
    // Pick an image
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      return base64Encode(bytes); // Convert to Base64 string
    } else {
      print("No image selected.");
      return null; // No image selected
    }
  } catch (e) {
    throw Exception("Error picking image: $e");
  }
}

Future<Uint8List> base64StringToImage(String base64String) async {
  try {
    Uint8List image =
        base64Decode(base64String); // Decode Base64 string to bytes
    return image;
  } catch (e) {
    throw Exception("Error converting Base64 to image: $e");
  }
}

void showImage(BuildContext context, String base64String) async {
  Uint8List imageBytes = await base64StringToImage(base64String);

  // Example: Display the image
  showDialog(
    // ignore: use_build_context_synchronously
    context: context,
    builder: (_) => AlertDialog(
      content: Image.memory(imageBytes),
    ),
  );
}

bool emailValidator(String email) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  // print(emailValid);
  return emailValid;
}

bool checkPassMatch(String pass1, String pass2) {
  return pass1 == pass2 ? true : false;
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
