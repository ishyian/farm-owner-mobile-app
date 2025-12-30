import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/views/alert_details_view/alert_details_view.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class AlertsView extends StatefulWidget {
  AlertsView({super.key, this.showBackIcon = true});

  bool showBackIcon;

  @override
  State<AlertsView> createState() => _AlertsViewState();
}

class _AlertsViewState extends State<AlertsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: "alerts".tr(),
        showBackIcon: widget.showBackIcon,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemBuilder: (context, index) {
          return buildSingleAlert();
        },
      ),
    );
  }

  Widget buildSingleAlert() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => locator<NavHelper>().push(const AlertDetailsView()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Title",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    16.horizontal(),
                    Text(
                      "5M",
                      style: kTiny10PxRegular.copyWith(color: kGrayText),
                    ),
                  ],
                ),
                8.vertical(),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                        style: TextStyle(fontSize: 12, color: kGrayText),
                      ),
                    ),
                    16.horizontal(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffEAF2FF),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        "announcement".tr().toUpperCase(),
                        style: const TextStyle(fontSize: 10, color: kPrimary500, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: const Divider(
              thickness: 0.3,
            ))
      ],
    );
  }
}
