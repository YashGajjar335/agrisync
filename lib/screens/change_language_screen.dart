import 'package:agrisync/provider/app_lang_provider.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLangScreen extends StatefulWidget {
  final bool? isPop;
  const ChangeLangScreen({super.key, this.isPop});

  @override
  State<ChangeLangScreen> createState() => _ChangeLangScreenState();
}

class _ChangeLangScreenState extends State<ChangeLangScreen> {
  String? selectedLang;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppLangProvider appLangProvider =
          Provider.of<AppLangProvider>(context, listen: false);
      setState(() {
        selectedLang = appLangProvider.lan.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLangProvider appLangProvider = Provider.of<AppLangProvider>(context);
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    void setLang(String lang) async {
      final lan = await SharedPreferences.getInstance();
      lan.setString("appLang", lang);
      appLangProvider.changeLang(lang);
      if (widget.isPop ?? true) {
        Navigator.of(context).pop();
      }
    }

    return AlertDialog(
      title: AgriSyncIcon(title: localizations.language),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text("English"),
            value: 'en',
            groupValue: selectedLang,
            onChanged: (value) {
              setState(() {
                selectedLang = value;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text("ગુજરાતી"),
            value: 'gu',
            groupValue: selectedLang,
            onChanged: (value) {
              setState(() {
                selectedLang = value;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text("हिंदी"),
            value: 'hi',
            groupValue: selectedLang,
            onChanged: (value) {
              setState(() {
                selectedLang = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: selectedLang != null ? () => setLang(selectedLang!) : null,
          child: const Text('done'),
        ),
      ],
    );
  }
}
