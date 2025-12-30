import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

import '../../../common/widgets/common/app_outlined_button.dart';
import '../../views/reg_animal_form_view/reg_animal_form_view.dart';

class EmptyRegisteredAnimalsView extends StatelessWidget {
  const EmptyRegisteredAnimalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            R.assetsImagesCommonNoAnimalsIcons,
            width: 150,
            height: 150,
          ),
          32.vertical(),
          Text(
            "no_animals_found".tr(),
            style: kH620PxMedium,
          ),
          8.vertical(),
          Text(
            "add_animals_and_their_details".tr(),
            style: kBody16PxRegular.copyWith(color: kDisabledColor),
            textAlign: TextAlign.center,
          ),
          32.vertical(),
          SizedBox(
              width: 250,
              child: AppButton(
                  title: "add_animal".tr(),
                  onPressed: () {
                    locator<NavHelper>().push(const RegisteredAnimalFormView());
                  })),
          16.vertical(),
          SizedBox(
              width: 250,
              child: AppOutlinedButton(
                  title: "scan_and_generate_tag".tr(),
                  onPressed: () {
                    //TODO
                  }))
        ],
      ),
    );
  }
}
