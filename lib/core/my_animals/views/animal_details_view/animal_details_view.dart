import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/ui_helper.dart';

class AnimalDetailsView extends StatefulWidget {
  const AnimalDetailsView({super.key, required this.animal});
  final MyAnimalResponse animal;

  @override
  State<AnimalDetailsView> createState() => _AnimalDetailsViewState();
}

class _AnimalDetailsViewState extends State<AnimalDetailsView> {
  @override
  Widget build(BuildContext context) {
    final animal = widget.animal;
    return Scaffold(
      appBar: AppAppBar(
        title: "animal_details".tr(),
        actions: [
          IconButton(
              onPressed: () {

              },
              icon: Image.asset(
                R.assetsImagesCommonEditIcon,
                width: 20,
              ))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          buildIdWidget(animal.species!.name ?? "Unknown", animal.id ?? "Unknown"),
          20.vertical(),
          buildRow(buildTitleValue("breed".tr(), animal.breed!.breed ?? "Unknown"),
              buildTitleValue("age".tr(), "${animal.age.toString()} years")),
          buildDivider(),
          buildRow(buildTitleValue("sex".tr(), animal.sex ?? "Unknown"),
              buildTitleValue("nick_name".tr(), animal.nickname ?? "Unknown")),
          buildDivider(),
          buildRow(buildTitleValue("ear_tag".tr(), animal.earTag ?? "Unknown"),
              buildTitleValue("animal_status".tr(), "3 Years")),
          buildDivider(),
          buildRow(buildTitleValue("animal_status".tr(), animal.status ?? "Unknown"),
              buildTitleValue("number_of_animals".tr(), animal.numberOfAnimals.toString())),
          buildDivider(),
          8.vertical(),
          buildTitle("vaccination_history".tr()),
          10.vertical(),
          ...animal.vaccinations!.map(
            (vaccination) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(child: buildValue(vaccination.genericName ?? "Unknown Vaccine")),
                  buildValue(vaccination.pivot?.vaccinationDoneOnDate != null
                      ? DateFormat('dd/MM/yyyy').format(
                      DateTime.parse(vaccination.pivot!.vaccinationDoneOnDate!))
                      : "Unknown Date")
                ],
              ),
            ),
          ),
          buildDivider(),
          8.vertical(),
          buildTitle("incident_history".tr()),
          10.vertical(),
          ...[1, 2, 3].map(
            (_) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                      child: buildValue("Wheezing when breathing,Diarrohea")),
                  buildValue("02/01/2024")
                ],
              ),
            ),
          ),
          buildDivider(),
          12.vertical(),
          buildTitleValue("remarks".tr(), "This is remarks text. Dummy texts."),
          12.vertical(),
          buildDivider(),
          12.vertical(),
          buildDocumentsWidget(),
        ],
      ),
    );
  }

  Widget buildIdWidget(String speciesName, String id) {
    return Column(
      children: [
         Text(
          speciesName,
          style: kBody16PxRegular,
        ),
        4.vertical(),
        Text(
          "${"id_".tr()} $id",
          style: kCaption14PxRegular.copyWith(color: kGrayText),
        ),
        12.vertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButtonIcon(
                R.assetsImagesCommonIncident, "incident".tr(), () {}),
            12.horizontal(),
            buildButtonIcon(R.assetsImagesCommonDownload, "download".tr(), () {
              locator<UiHelper>()
                  .showSnackBar("Currently no API availble", isError: true);
            }),
            12.horizontal(),
            buildButtonIcon(R.assetsImagesCommonQrCode, "qr_code".tr(), () {
              locator<UiHelper>()
                  .showSnackBar("Currently no API availble", isError: true);
            }),
          ],
        )
      ],
    );
  }

  Widget buildButtonIcon(String image, String title, VoidCallback onTap) {
    return Container(
      // width: 80,
      // height: 55,
      decoration: BoxDecoration(
          color: kPrimary100, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
