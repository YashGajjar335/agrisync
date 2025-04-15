import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isLoad = false;
  String? userName;
  String? photoUrl;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  loadUserData() async {
    final user = await AuthServices.instance.getCurrentUserDetail();
    userName = user['uname'];
    photoUrl = user['profilePic'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AgriSyncIcon(
          title: appLocalizations.edit_profile,
          size: 25,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: userName == null && photoUrl == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // edit profile photo
                  Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: (photoUrl == null || photoUrl!.isEmpty)
                              ? CircleAvatar(
                                  radius: 40,
                                  child: _isLoad
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : const Icon(Icons.person,
                                          color: Colors.black, size: 30),
                                )
                              : StringImageInCircleAvatar(
                                  base64ImageString: photoUrl!,
                                  radius: 40,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              final pickedImage =
                                  await pickImageAndConvertToBase64();

                              if (pickedImage != null) {
                                setState(() {
                                  photoUrl = pickedImage;
                                });
                              } else {
                                showSnackBar("Fetch Image failed", context);
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              child: const Icon(
                                Icons.photo_camera_back_rounded,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  TextField(
                    autocorrect: true,
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: userName,
                      hintText: userName,
                      fillColor: Colors.red,
                    ),
                  ),
                  LongButton(
                      isLoading: _isLoad,
                      width: double.infinity,
                      buttonText: appLocalizations.submit,
                      onTap: () async {
                        setState(() {
                          _isLoad = !_isLoad;
                        });
                        if (_nameController.text.isNotEmpty) {
                          final res = await AuthServices.instance
                              .updateUsernameAndProfilePic(
                                  photoUrl ?? "", _nameController.text.trim());
                          if (res == null) {
                            showSnackBar(
                                appLocalizations.profile_updated_success,
                                context);
                            Navigator.pop(context, 'update');
                          } else {
                            showSnackBar(res, context);
                          }
                        } else {
                          showSnackBar(appLocalizations.enterUserName, context);
                        }

                        setState(() {
                          _isLoad = !_isLoad;
                        });
                      })
                ],
              ),
      ),
    );
  }
}
