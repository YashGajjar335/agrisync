import 'package:agrisync/provider/app_lang_provider.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/long_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLangScreen extends StatefulWidget {
  const ChangeLangScreen({super.key});

  @override
  State<ChangeLangScreen> createState() => _ChangeLangScreenState();
}

class _ChangeLangScreenState extends State<ChangeLangScreen> {
  @override
  Widget build(BuildContext context) {
    AppLangProvider appLangProvider = Provider.of<AppLangProvider>(context);

    final AppLocalizations localizations = AppLocalizations.of(context)!;
    void setLang(String lang) async {
      final lan = await SharedPreferences.getInstance();
      lan.setString("appLang", lang);
      appLangProvider.changeLang(lang);
      // setState(() {});
      print(lan.getString('appLang'));
      print(appLangProvider.lan);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }

    return AlertDialog(
      title: AgriSyncIcon(title: localizations.language),
      actions: [
        LongButton(
            width: double.infinity,
            name: "English",
            onTap: () {
              setLang('en');
            }),
        LongButton(
            width: double.infinity,
            name: "ગુજરાતી",
            onTap: () {
              setLang('gu');
            }),
        LongButton(
            width: double.infinity,
            name: "हिंदी",
            onTap: () {
              setLang('hi');
            }),
      ],
    );
  }
}
