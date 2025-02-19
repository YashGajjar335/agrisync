import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agrisync/screens/agri_tech/agri_tech_screen.dart';
import 'package:agrisync/screens/crop/crop_list_screen.dart';
import 'package:agrisync/screens/agri_sync_home_screen.dart';
import 'package:agrisync/screens/auth/login_screen.dart';
import 'package:agrisync/screens/agri_mart/agri_mart_screen.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;

// String userPhotoUrl =
//     "/9j/4QBqRXhpZgAATU0AKgAAAAgABAEAAAQAAAABAAAEsAEBAAQAAAABAAADiYdpAAQAAAABAAAAPgESAAMAAAABAAAAAAAAAAAAAZIIAAMAAAABAAAAAAAAAAAAAQESAAMAAAABAAAAAAAAAAD/4AAQSkZJRgABAQAAAQABAAD/4gIoSUNDX1BST0ZJTEUAAQEAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANv/bAEMAEAsMDgwKEA4NDhIREBMYKBoYFhYYMSMlHSg6Mz08OTM4N0BIXE5ARFdFNzhQbVFXX2JnaGc+TXF5cGR4XGVnY//bAEMBERIS";

String appLocalization = "package:flutter_gen/gen_l10n/app_localizations.dart";
String assets = "assets/";
List<Widget> tabItems = const [
  CropListScreen(crop: "ANY"),
  AgriMartScreen(),
  AgriSyncHomeScreen(),
  LoginScreen(),
  AgriTechScreen(),
];

Future<String?> pickImageAndConvertToBase64({int imageQuality = 10}) async {
  try {
    final picker = ImagePicker();
    // Pick an image
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: imageQuality);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      print("Image is : $bytes");
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
      content: TextLato(
        text: content,
      ),
    ),
  );
}

String simplyDateFormat({required DateTime time, bool dateOnly = false}) {
  String year = time.year.toString();
  String month = time.month.toString().padLeft(2, '0');
  String day = time.day.toString().padLeft(2, '0');
  String hour = time.hour.toString().padLeft(2, '0');
  String minute = time.minute.toString().padLeft(2, '0');
  String second = time.second.toString().padLeft(2, '0');

  if (dateOnly) {
    return "$day-$month-$year";
  }
  return "$day-$month-$year $hour:$minute:$second";
}

// check userMatch
bool isSameUser(String user2) {
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  return currentUser == user2;
}

alertMessage(String title, String message, void Function() funciton,
    BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: TextLato(
        text: title,
      ),
      content: SingleChildScrollView(
        child: TextLato(text: message),
      ),
      actions: [
        TextButton(
            onPressed: () {
              funciton();
              Navigator.pop(context);
            },
            child: const TextLato(
              text: "Okay",
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const TextLato(
              text: "Cancel",
            )),
      ],
    ),
  );
}
