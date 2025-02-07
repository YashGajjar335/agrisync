import 'package:agrisync/screens/auth/login_screen.dart';
import 'package:agrisync/screens/onbording_screen.dart';
import 'package:agrisync/screens/change_language_screen.dart';
import 'package:agrisync/screens/profile_screen.dart';
import 'package:agrisync/services/login_services.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/text_lato.dart';
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
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen())),
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primaryFixedDim,
              ),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundColor: theme.primaryContainer,
                backgroundImage: AssetImage(AgrisyncImageIcon().profile),
              ),
              accountName: Text(
                "UserName",
                style: GoogleFonts.lato(
                    color: theme.primary, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              accountEmail: Text(
                "abcd123@gmail.com",
                style: GoogleFonts.lato(
                  color: theme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().home,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "Home"),
                onTap: () {},
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().cropHealthReminder,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "Crop Health Reminder"),
                onTap: () {},
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().technology,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "Crop Technologu"),
                onTap: () {},
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().socialPage,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "Communication"),
                onTap: () {},
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().shoppingCart,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "AgriMart"),
                onTap: () {},
              ),
              divider,
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().profile,
                  height: 30,
                  width: 30,
                ),
                title: const TextLato(text: "EditProfile"),
                onTap: () {},
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
