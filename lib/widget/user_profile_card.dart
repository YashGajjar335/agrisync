import 'package:agrisync/services/auth_services.dart';
import 'package:agrisync/utils/agrisync_image_icon.dart';
import 'package:agrisync/widget/string_image_in_circle_avtar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileCard extends StatefulWidget {
  final bool isProfileUpdate;
  const UserProfileCard({super.key, required this.isProfileUpdate});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  String? photoUrl;
  String? userName;
  String? emailId;

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UserProfileCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isProfileUpdate != widget.isProfileUpdate) {
      loadUserData();
    }
  }

  loadUserData() async {
    final user = await AuthServices.instance.getCurrentUserDetail();
    photoUrl = user['profilePic'];
    userName = user['uname'];
    emailId = user['email'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return photoUrl == null && userName == null && emailId == null
        ? const SizedBox(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primaryFixedDim,
            ),
            currentAccountPicture: photoUrl!.isEmpty
                ? CircleAvatar(
                    radius: 50,
                    backgroundColor: theme.primaryContainer,
                    backgroundImage: AssetImage(AgrisyncImageIcon().profile),
                  )
                : StringImageInCircleAvatar(
                    base64ImageString: photoUrl!,
                    radius: 70,
                  ),
            accountName: Text(
              userName!,
              style: GoogleFonts.lato(
                  color: theme.primary, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            accountEmail: Text(
              emailId!,
              style: GoogleFonts.lato(
                color: theme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          );
  }
}
