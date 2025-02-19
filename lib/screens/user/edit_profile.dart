import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const AgriSyncIcon(
          title: "Edit Profile",
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
                            child: photoUrl!.isEmpty
                                ? CircleAvatar(
                                    radius: 40,
                                    child: _isLoad
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Icon(
                                            Icons.person,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                  )
                                : StringImageInCircleAvatar(
                                    base64ImageString: photoUrl!,
                                    radius: 40,
                                  )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoad = !_isLoad;
                              });
                              photoUrl = await pickImageAndConvertToBase64();

                              setState(() {
                                _isLoad = !_isLoad;
                              });
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
                      buttonText: "Submit",
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
                                "Profile Updated Successfully", context);
                            Navigator.pop(context);
                          } else {
                            showSnackBar(res, context);
                          }
                        } else {
                          showSnackBar("Enter Name ", context);
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
