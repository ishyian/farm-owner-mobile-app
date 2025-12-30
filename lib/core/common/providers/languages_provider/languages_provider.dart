import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class LanguageProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> languages = [
    {"code": "en", "flag": R.assetsImagesFlagsEn},
    {"code": "ar", "flag": R.assetsImagesFlagsAr},
  ];

  Map<String, dynamic>? _currentLanguage;

  LanguageProvider() {
    _currentLanguage = languages.firstWhere((language) =>
        language["code"] ==
        locator<NavHelper>().navigatorKey.currentContext!.locale.languageCode);
  }

  Map<String, dynamic>? get currentLanguage => _currentLanguage;

  void setLanguage(Map<String, dynamic> language) {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      locator<NavHelper>()
          .navigatorKey
          .currentContext!
          .setLocale(Locale(language["code"]));
      notifyListeners();
    }
  }
}
