import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/api/model/home/observations_response.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/observations/providers/initial_screening_detail_provider/initial_screening_detail_provider.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/extensions/string.dart';

class InitialScreeningDetailsView extends StatefulWidget {
  const InitialScreeningDetailsView({super.key, required this.id});

  final String id;

  @override
  State<InitialScreeningDetailsView> createState() =>
      _InitialScreeningDetailsViewState();
}

class _InitialScreeningDetailsViewState
    extends State<InitialScreeningDetailsView> {
  late InitialScreeningDetailProvider provider;

  @override
  void initState() {
    provider =
        Provider.of<InitialScreeningDetailProvider>(context, listen: false);
    Future.microtask(() {
      provider.fetchAnimalScreening(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InitialScreeningDetailProvider>(
        builder: (BuildContext context, provider, Widget? child) {
      return Scaffold(
        appBar: AppAppBar(
          title: "observation_details".tr(),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          children: [
            buildIdWidget(provider.animalScreening),
            20.vertical(),
            buildSymptomsRow(provider.animalScreening?.symptoms ?? []),
            12.vertical(),
            buildDivider(),
            12.vertical(),
            buildDiseasesRow(provider.animalScreening?.diseases ?? []),
            12.vertical(),
            buildDivider(),
            12.vertical(),
            buildTitleValue(
                "remarks".tr(), provider.animalScreening?.remarks ?? ''),
            12.vertical(),
            buildDivider(),
            12.vertical(),
            buildDocumentsWidget(provider.animalScreening?.files ?? []),
          ],
        ),
      );
    });
  }

  Widget buildIdWidget(AnimalScreening? animalScreening) {
    return Column(
      children: [
        Text(
          "initial_screening".tr(),
          style: kBody16PxRegular,
        ),
        4.vertical(),
        Text(
          "${"animal_batch_id".tr()} ${animalScreening?.id ?? ''}",
          style: kCaption14PxRegular.copyWith(color: kGrayText),
        ),
        12.vertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: animalScreening?.screeningResult == "pass"
                      ? kAlertSuccess
                      : kAlertWarning),
            ),
            4.horizontal(),
            Text(
              animalScreening?.screeningResult.capitalize() ?? '',
            ),
          ],
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

  Widget buildRow(Widget child1, Widget child2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(child: child1),
          12.horizontal(),
          Expanded(child: child2),
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

  Widget buildDocumentsWidget(List<ScreeningFile> files) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle("documents".tr()),
        10.vertical(),
        ...files.map(
          (file) => GestureDetector(
            onTap: () {
              debugPrint('File URL: ${file.url}');
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                      child: buildValue(file.filename ??
                          "Document ${files.indexOf(file) + 1}")),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kPrimary500,
                    ),
                    child: Center(
                      child: Image.asset(
                        R.assetsImagesCommonDownload,
                        color: Colors.white,
                        width: 14,
                        height: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSymptomsRow(List<ScreeningSymptom> symptoms) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${symptoms.length} ${"symptoms".tr()}",
              style: kSmall12PxRegular,
            ),
            8.vertical(),
            ListView(
              shrinkWrap: true,
              children: (symptoms).map((symptom) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      symptom.name ?? '',
                      style: kBody16PxRegular,
                    ),
                    16.horizontal(),
                  ],
                );
              }).toList(),
            )
          ],
        ),
        8.vertical(),
        Center(
          child: SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: ([]).map((f) {
                return Row(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                R.assetsImagesCommonImage,
                                width: 38,
                                height: 38,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                          8.vertical(),
                          const Text(
                            "0233.jpg",
                            maxLines: 1,
                            style: kSmall12PxRegular,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    16.horizontal(),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDiseasesRow(List<ScreeningDisease> diseases) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "diseases".tr(),
              style: kSmall12PxRegular,
            ),
            8.vertical(),
            ListView(
              shrinkWrap: true,
              children: (diseases).map((disease) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      disease.name ?? '',
                      style: kBody16PxRegular,
                    ),
                    16.horizontal(),
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ],
    );
  }
}
