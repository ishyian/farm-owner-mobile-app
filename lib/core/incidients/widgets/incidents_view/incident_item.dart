import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/utils/extensions/num.dart';

class IncidentItem extends StatefulWidget {
  const IncidentItem({super.key, required this.index});
  final int index;
  @override
  State<IncidentItem> createState() => _IncidentItemState();
}

class _IncidentItemState extends State<IncidentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '#HS000012 - Horse',
                      style: kCaption14PxRegular,
                    ),
                    4.vertical(),
                    Text(
                      'Wheezing when breathing',
                      style: kSmall12PxRegular.copyWith(color: kGrayText),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: kGrayText,
                size: 14,
              )
            ],
          ),
          16.vertical(),
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: getColor()),
              ),
              4.horizontal(),
              const Expanded(
                child: Text(
                  "Closed",
                ),
              ),
              Text(
                "view_remarks".tr(),
                style: kSmall12PxMedium.copyWith(color: kDarkPrimary),
              )
            ],
          )
        ],
      ),
    );
  }

  Color getColor() {
    if (widget.index % 2 == 0) {
      return kAlertError;
    } else {
      return kAlertWarning;
    }
  }
}
