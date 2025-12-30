import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/core/my_animals/views/animal_form_view/animal_form_view.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class EmptyObservationView extends StatelessWidget {
  const EmptyObservationView({super.key, required this.isInitialScreening});

  final bool isInitialScreening;

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
            isInitialScreening ? "no_screening_found".tr() : "no_postmortem_found".tr(),
            style: kH620PxMedium,
          ),
          8.vertical(),
          Text(
            isInitialScreening ? "add_screening_and_details".tr() : "add_postmortem_and_details".tr(),
            style: kBody16PxRegular.copyWith(color: kDisabledColor),
            textAlign: TextAlign.center,
          ),
          32.vertical(),
          SizedBox(
              width: 200,
              child: AppButton(
                  title: isInitialScreening ? "add_initial_screening".tr() : "add_postmortem".tr(),
                  onPressed: () {
                    locator<NavHelper>().push(const AnimalFormView(isIndividual: true));
                  }))
        ],
      ),
    );
  }
}
