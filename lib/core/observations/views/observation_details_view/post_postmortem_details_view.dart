import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/observations/providers/post_portem_detail_provider/post_mortem_detail_provider.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';

class PostmortemDetailsView extends StatefulWidget {
  const PostmortemDetailsView({super.key, required this.id});

  final String id;

  @override
  State<PostmortemDetailsView> createState() => _PostmortemDetailsViewState();
}

class _PostmortemDetailsViewState extends State<PostmortemDetailsView> {
  late PostMortemDetailProvider provider;

  @override
  void initState() {
    provider = Provider.of<PostMortemDetailProvider>(context, listen: false);
    Future.microtask(() {
      provider.fetchPostMortem(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostMortemDetailProvider>(
        builder: (BuildContext context, provider, Widget? child) {
      return Scaffold(
        appBar: AppAppBar(
          title: "observation_details".tr(),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              buildIdWidget(),
              20.vertical(),
              buildRow(
                  buildTitleValue("post_mortem_date".tr(),
                      provider.postMortem?.dateOfPostMortem ?? ''),
                  child2: buildTitleValue("animals_screened".tr(),
                      "${provider.postMortem?.noOfAnimalsScreened ?? 0} Animals")),
              buildDivider(),
              buildRow(buildTitleValue("no_animals_organs_collected".tr(),
                  "${provider.postMortem?.noOfAnimalsOrgansCollected ?? 0} Animals")),
              buildDivider(),
              8.vertical(),
              Expanded(
                child: ListView(
                  // shrinkWrap: true,
                  children: (provider.postMortem?.details ?? []).map((detail) {
                    return Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      margin: const EdgeInsets.only(bottom: 8, top: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRow(
                              buildTitleValue("animal_batch_id".tr(),
                                  detail.animalId ?? ''),
                              child2: buildTitleValue(
                                  "carcass_condemnation".tr(),
                                  detail.carcassCondemnation ?? '')),
                          buildDivider(),
                          buildRow(
                              buildTitleValue("examined_organ".tr(),
                                  detail.examinedOrgan ?? ''),
                              child2: buildTitleValue("observation".tr(),
                                  detail.observation ?? '')),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget buildIdWidget() {
    return Column(
      children: [
        Text(
          "post_postmortem".tr(),
          style: kBody16PxRegular,
        ),
        4.vertical(),
        Text(
          "${"lab_test_id".tr()} HS00012",
          style: kCaption14PxRegular.copyWith(color: kGrayText),
        ),
      ],
    );
  }

  Widget buildButtonIcon(String image, String title, VoidCallback onTap) {
    return Container(
      width: 80,
      height: 55,
      decoration: BoxDecoration(
          color: kPrimary100, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 24,
            height: 24,
          ),
          4.vertical(),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: kPrimaryColor),
          ),
        ],
      ),
    );
  }

  Widget buildValue(String title) {
    return Text(
      title,
      style: kBody16PxRegular,
    );
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: kCaption14PxRegular.copyWith(color: kGrayText),
    );
  }

  Widget buildTitleValue(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(title),
        4.vertical(),
        buildValue(value),
      ],
    );
  }

  Widget buildRow(Widget child1, {Widget? child2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(child: child1),
          if (child2 != null) ...[
            12.horizontal(),
            Expanded(child: child2),
          ]
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      height: 0.2,
      color: const Color(0xff1F2024).withOpacity(0.5),
    );
  }

  Widget buildDocumentsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle("documents".tr()),
        10.vertical(),
        ...[1, 2, 3].map(
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(child: buildValue("Document 1")),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kPrimary500),
                  child: Center(
                    child: Image.asset(
                      R.assetsImagesCommonDownload,
                      color: Colors.white,
                      width: 14,
                      height: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
