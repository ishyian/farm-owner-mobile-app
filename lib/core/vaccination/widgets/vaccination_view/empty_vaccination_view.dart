import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';

class EmptyVaccinationView extends StatelessWidget {
  const EmptyVaccinationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            R.assetsImagesCommonImage,
            width: 100,
            fit: BoxFit.fill,
            height: 100,
          ),
          32.vertical(),
          Text(
            "no_upcoming_vaccination".tr(),
            style: kH620PxMedium,
          ),
          8.vertical(),
          Text(
            "you_will_be_notified_here_for_vaccination".tr(),
            style: kBody16PxRegular.copyWith(color: kDisabledColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
