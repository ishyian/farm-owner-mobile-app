import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/providers/languages_provider/languages_provider.dart';
import 'package:weqaa/utils/extensions/num.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return DropdownButtonHideUnderline(
            child: DropdownButton2<Map<String, dynamic>>(
              customButton: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    languageProvider.currentLanguage!["flag"],
                    width: 24,
                    height: 24,
                  ),
                  4.horizontal(),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: kPrimaryColor,
                  ),
                ],
              ),
              items: languageProvider.languages.map((language) {
                return DropdownMenuItem(
                  value: language,
                  child: Row(
                    children: [
                      Image.asset(
                        language["flag"],
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(language["code"].toString().tr(),
                          style: kBody16PxRegular),
                    ],
                  ),
                );
              }).toList(),
              value: languageProvider.currentLanguage,
              onChanged: (newLanguage) {
                if (newLanguage != null) {
                  languageProvider.setLanguage(newLanguage);
                }
              },
              dropdownStyleData: DropdownStyleData(
                width: 160,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                elevation: 8,
                offset: const Offset(0, 8),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}
