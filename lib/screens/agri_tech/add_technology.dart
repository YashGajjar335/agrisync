// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/screens/agri_tech/agri_tech_screen.dart';
import 'package:agrisync/services/agri_tech_service.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class AddTechnology extends StatefulWidget {
  const AddTechnology({super.key});

  @override
  State<AddTechnology> createState() => _AddTechnologyState();
}

class _AddTechnologyState extends State<AddTechnology> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String imageUrl = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AgriSyncIcon(
          title: "Add Technology",
          size: 30,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Show selected photo
                if (imageUrl.isNotEmpty)
                  Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: StringImage(base64ImageString: imageUrl),
                  ),
                const SizedBox(height: 20),
                // Button to select the photo
                LongButton(
                  width: 300,
                  buttonText: "Select Photo",
                  onTap: () async {
                    final image = await pickImageAndConvertToBase64();
                    if (image != null) {
                      setState(() {
                        imageUrl = image;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                // Technology Title Field
                TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the Technology Title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const TextLato(text: "Technology Title"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Description Field
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the Description";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const TextLato(text: "Description"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Button to upload technology
                LongButton(
                  isLoading: _isLoading,
                  width: 200,
                  buttonText: "Share Technology",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      final res = await AgriTechService.instance
                          .uploadTechnology(_titleController.text,
                              _descriptionController.text, imageUrl);
                      if (res == null) {
                        showSnackBar(
                            "Technology Uploaded Successfully", context);
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => const AgriTechScreen(),
                        //   ),
                        // );
                        Navigator.pop(context);
                      } else {
                        showSnackBar(res, context);
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
