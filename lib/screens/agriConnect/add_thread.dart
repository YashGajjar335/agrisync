// ignore_for_file: use_build_context_synchronously

import 'package:agrisync/services/agri_connect_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/colors.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class AddThread extends StatefulWidget {
  const AddThread({super.key});

  @override
  State<AddThread> createState() => _AddThreadState();
}

class _AddThreadState extends State<AddThread> {
  final TextEditingController _description = TextEditingController();
  String imageUrl = "";
  final SizedBox _sizedBox = const SizedBox(
    height: 20,
  );
  bool _isLoad = false;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: AgriSyncIcon(title: appLocalizations.upload_thread, size: 25),
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
                // show photo for thread
                if (imageUrl.isNotEmpty)
                  Container(
                      height: 500,
                      width: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(12)),
                      child: StringImage(base64ImageString: imageUrl)),
                _sizedBox,
                // button for select the photo
                LongButton(
                  width: 300,
                  buttonText: appLocalizations.selectPhoto,
                  onTap: () async {
                    final image = await pickImageAndConvertToBase64();
                    imageUrl = image!;
                    setState(() {});
                  },
                ),
                _sizedBox,
                // adding description
                TextFormField(
                  controller: _description,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return appLocalizations.enter_description;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorText: appLocalizations.enter_description,
                    label: TextLato(
                      text: appLocalizations.description,
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: bottomGreen),
                    ),
                  ),
                ),
                _sizedBox,
                // button for the upload thread to firebaseFirestore
                LongButton(
                    isLoading: _isLoad,
                    width: 200,
                    buttonText: appLocalizations.upload_thread,
                    onTap: () async {
                      setState(() {
                        _isLoad = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        final res = await AgriConnectService.instance
                            .uploadThread(imageUrl, _description.text.trim());
                        if (res == null) {
                          showSnackBar(
                              appLocalizations.thread_upload_success, context);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => const AgriConnectScreen()));
                          Navigator.pop(context);
                        } else {
                          showSnackBar(res, context);
                          imageUrl = "";
                          _description.dispose();
                          setState(() {});
                        }
                      }
                      setState(() {
                        _isLoad = false;
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
