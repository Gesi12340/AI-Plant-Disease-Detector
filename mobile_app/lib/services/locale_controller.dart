import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController {
  static final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

  static void setLocale(Locale locale) {
    localeNotifier.value = locale;
    _saveLocale(locale.languageCode);
  }

  static Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('languageCode') ?? 'en';
    localeNotifier.value = Locale(code);
  }

  static Future<void> _saveLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', code);
  }
}
