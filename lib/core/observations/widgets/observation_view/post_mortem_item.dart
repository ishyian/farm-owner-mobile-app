import 'package:flutter/material.dart';
import 'package:weqaa/api/model/home/observations_response.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/observations/views/observation_details_view/post_postmortem_details_view.dart';
import 'package:weqaa/utils/extensions/num.dart';

import '../../../../utils/helpers/locator.dart';
import '../../../../utils/helpers/nav_helper.dart';

class PostmortemItem extends StatefulWidget {
  const PostmortemItem({super.key, required this.index, required this.postMortem});

  final int index;
  final PostMortem postMortem;

  @override
  State<PostmortemItem> createState() => _PostmortemItemState();
}

class _PostmortemItemState extends State<PostmortemItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => locator<NavHelper>()
          .push(PostmortemDetailsView(id: widget.postMortem.id)),
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
                      const Text(
                        '#HS000012 - Horse',
                        style: kCaption14PxRegular,
                      ),
                      8.vertical(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildDetailColumn("Postmortem Date", widget.postMortem.dateOfPostMortem.toString()),
                          buildDetailColumn("Animals Screened", widget.postMortem.noOfAnimalsScreened.toString()),
                          buildDetailColumn("Animal Organs Collected", widget.postMortem.noOfAnimalsOrgansCollected.toString()),
                        ],
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
          ],
        ),
      ),
    );
  }

  Widget buildDetailColumn(String title, String value) {
    return SizedBox(
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: kSmall12PxRegular.copyWith(color: kGrayText),
          ),
          8.vertical(),
          Text(
            value,
            style: kSmall12PxMedium.copyWith(color: kGrayText),
          ),
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
