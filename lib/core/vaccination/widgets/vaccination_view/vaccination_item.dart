import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/vaccination/widgets/vaccination_view/mark_as_done_bottom_sheet.dart';

class VaccinationItem extends StatefulWidget {
  const VaccinationItem({super.key});

  @override
  State<VaccinationItem> createState() => _VaccinationItemState();
}

class _VaccinationItemState extends State<VaccinationItem> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("#1234567890- Horse",
              style: kCaption14PxRegular.copyWith(color: Colors.black)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text("Tetanus Vaccination",
                style: kSmall12PxRegular.copyWith(color: kGrayText)),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${"due_on".tr()} ${DateFormat("dd/MM/yyyy").format(DateTime.now())}",
                  style: kSmall12PxRegular.copyWith(color: kGrayText),
                ),
              ),
              GestureDetector(
                onTap: markAsDone,
                child: Text(
                  "mark_as_done".tr(),
                  style: const TextStyle(
                      color: kDarkPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void markAsDone() {
    MarkAsDoneBottomSheet.show();
  }
}
