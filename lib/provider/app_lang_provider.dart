import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLangProvider extends ChangeNotifier {
  Locale _lan = const Locale("en"); // Default locale

  AppLangProvider() {
    setup();
  }

  Future<void> setup() async {
    final langpref = await SharedPreferences.getInstance();
    final languageCode = langpref.getString('appLang') ?? "en";
    _lan = Locale(languageCode);
    print("Language initialized: $languageCode");
    notifyListeners(); // Notify after initialization
  }

  Locale get lan => _lan;

  Future<void> changeLang(String languageCode) async {
    _lan = Locale(languageCode);
    final langpref = await SharedPreferences.getInstance();
    await langpref.setString('appLang', languageCode);
    print("Language changed to: $languageCode");
    notifyListeners(); // Notify listeners after changing language
  }
}
