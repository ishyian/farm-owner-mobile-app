import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool isRTL() {
    return Directionality.of(this) == TextDirection.rtl;
  }

  bool isArabic({BuildContext? context}) {
    return (locale.languageCode) == "ar";
  }
}
