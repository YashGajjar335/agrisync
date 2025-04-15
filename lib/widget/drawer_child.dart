import 'package:agrisync/screens/agri_mart/user_order_screen.dart';
import 'package:agrisync/screens/feedback/feedback_screen.dart';
import 'package:agrisync/screens/auth/login_screen.dart';
import 'package:agrisync/screens/feedback/help_screen.dart';
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
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class DrawerChild extends StatefulWidget {
  const DrawerChild({super.key});

  @override
  State<DrawerChild> createState() => _DrawerChildState();
}

class _DrawerChildState extends State<DrawerChild> {
  bool isProfileUpdate = false;
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context).colorScheme;
    Divider divider = Divider(
      thickness: 5,
      color: theme.primary,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 10),
          child: AgriSyncIcon(title: appLocalizations.user_profile),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen())),
              child: UserProfileCard(
                isProfileUpdate: isProfileUpdate,
              )),
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
                title: TextLato(text: appLocalizations.edit_profile),
                onTap: () async {
                  final res = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfile()),
                  );

                  if (res == 'update') {
                    setState(() {
                      isProfileUpdate = !isProfileUpdate;
                    });
                  }
                },
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().shoppingCart,
                  height: 30,
                  width: 30,
                ),
                title: TextLato(text: appLocalizations.my_order),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const UserOrderScreen())),
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().language,
                  height: 30,
                  width: 30,
                ),
                title: TextLato(text: appLocalizations.language),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => const ChangeLangScreen());
                },
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().onBording,
                  height: 30,
                  width: 30,
                ),
                title: TextLato(text: appLocalizations.onboarding_screen),
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
                title: TextLato(text: appLocalizations.feedback),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FeedbackScreen()));
                },
              ),
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().help,
                  height: 30,
                  width: 30,
                ),
                title: TextLato(text: appLocalizations.help),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HelpScreen())),
              ),
              divider,
              ListTile(
                leading: Image.asset(
                  AgrisyncImageIcon().logout,
                  height: 30,
                  width: 30,
                ),
                title: TextLato(text: appLocalizations.logout),
                onTap: () async {
                  String? res = await AuthServices.instance.logOut();
                  res == null
                      ? Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        )
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
