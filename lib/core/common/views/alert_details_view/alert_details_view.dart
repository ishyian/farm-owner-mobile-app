import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/utils/extensions/num.dart';

class AlertDetailsView extends StatefulWidget {
  const AlertDetailsView({super.key});

  @override
  State<AlertDetailsView> createState() => _AlertDetailsViewState();
}

class _AlertDetailsViewState extends State<AlertDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: "announcement_details".tr(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et",
            style: kBody16PxMedium.copyWith(color: Colors.black),
          ),
          8.vertical(),
          Text(
            DateFormat("d MMMM, yyyy h:mma").format(
              DateTime.now(),
            ),
            style: kSmall12PxRegular.copyWith(color: kGrayText),
          ),
          24.vertical(),
          Text(
            "lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et sit amet, consectetur adipiscing elit. Sed et",
            style: kBody16PxRegular.copyWith(color: kGrayText),
          ),
        ],
      ),
    );
  }
}
