import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/core/incidients/views/incident_form_view/incident_form_view.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class EmptyIncidentsView extends StatelessWidget {
  const EmptyIncidentsView({super.key});

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
            "no_incidents_found".tr(),
            style: kH620PxMedium,
          ),
          8.vertical(),
          Text(
            "add_incidents_and_their_details".tr(),
            style: kBody16PxRegular.copyWith(color: kDisabledColor),
            textAlign: TextAlign.center,
          ),
          32.vertical(),
          SizedBox(
              width: 150,
              child: AppButton(
                  title: "add_incident".tr(),
                  onPressed: () {
                    locator<NavHelper>().push(const IncidentFormView());
                  }))
        ],
      ),
    );
  }
}
