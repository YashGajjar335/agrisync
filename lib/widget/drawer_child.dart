import 'package:agrisync/screens/auth/login_screen.dart';
import 'package:agrisync/screens/onbording_screen.dart';
import 'package:agrisync/screens/change_language_screen.dart';
import 'package:agrisync/screens/user/edit_profile.dart';
import 'package:agrisync/screens/user/profile_screen.dart';
import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:agrisync/widget/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerChild extends StatefulWidget {
  const DrawerChild({super.key});

  @override
  State<DrawerChild> createState() => _DrawerChildState();
}

class _DrawerChildState extends State<DrawerChild> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    Divider divider = Divider(
      thickness: 5,
      color: theme.primary,
    );
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: AgriSyncIcon(title: "UserProfile"),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen())),
              child: const UserProfileCard()),
        ),
        Expanded(
          child: ListView(
            children: [
              divider,
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().profile,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "Edit Profile"),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const EditProfile())),
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().language,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "Language"),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const ChangeLangScreen())),
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().onBording,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "OnBordingScreen"),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const OnBordingScreen())),
              ),
              divider,
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().feedback,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "feedback"),
                onTap: () {},
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().help,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "help"),
                onTap: () {},
              ),
              divider,
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().logout,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "LogOut"),
                onTap: () async {
                  String? res = await AuthServices.instance.logOut();
                  res == null
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ))
                      : showSnackBar(res, context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
