import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class MarkAsDoneBottomSheet extends StatefulWidget {
  const MarkAsDoneBottomSheet({
    super.key,
  });

  static Future show() async {
    showModalBottomSheet(
      context: locator<NavHelper>().navigatorKey.currentContext!,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const MarkAsDoneBottomSheet();
      },
      isScrollControlled: true,
    );
  }

  @override
  State<MarkAsDoneBottomSheet> createState() => _MarkAsDoneBottomSheetState();
}

class _MarkAsDoneBottomSheetState extends State<MarkAsDoneBottomSheet> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 36,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "mark_as_done".tr(),
                style: kH620PxMedium,
                textAlign: TextAlign.center,
              ),
              16.vertical(),
              Text(
                "select_vaccination_date".tr(),
                style: kSmall12PxRegular,
              ),
              8.vertical(),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: pickDate,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kStrokeColor),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 46,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        DateFormat("dd/MM/yyyy").format(selectedDate),
                        style: kBody16PxRegular,
                      )),
                      Image.asset(
                        R.assetsImagesCommonCalendar,
                        width: 18,
                      )
                    ],
                  ),
                ),
              ),
              16.vertical(),
              AppButton(
                  title: "confirm".tr(),
                  onPressed: () {
                    locator<NavHelper>().pop();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future pickDate() async {
    final res = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (res != null) {
      setState(() {
        selectedDate = res;
      });
    }
  }
}
