import 'package:flutter/material.dart';
import 'package:weqaa/api/model/home/observations_response.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/observations/views/observation_details_view/initial_screening_details_view.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/extensions/string.dart';

import '../../../../utils/helpers/locator.dart';
import '../../../../utils/helpers/nav_helper.dart';

class InitialScreeningItem extends StatefulWidget {
  const InitialScreeningItem(
      {super.key, required this.index, required this.animalScreening});

  final int index;
  final AnimalScreening animalScreening;

  @override
  State<InitialScreeningItem> createState() => _InitialScreeningItemState();
}

class _InitialScreeningItemState extends State<InitialScreeningItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => locator<NavHelper>().push(
          InitialScreeningDetailsView(id: widget.animalScreening.id ?? '')),
      child: Container(
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
                      Text(
                        '#${widget.animalScreening.animal?.animalId ?? ''}-${widget.animalScreening.animal?.nickname ?? ''}',
                        style: kCaption14PxRegular,
                      ),
                      4.vertical(),
                      Text(
                        widget.animalScreening.symptoms
                                ?.map((symptom) => symptom.name)
                                .join(', ') ??
                            '',
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
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColor(widget.animalScreening.screeningResult)),
                ),
                4.horizontal(),
                Expanded(
                  child: Text(
                    widget.animalScreening.screeningResult.capitalize(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color getColor(String screeningResult) {
    return screeningResult == "pass" ? kAlertSuccess : kAlertWarning;
  }
}
