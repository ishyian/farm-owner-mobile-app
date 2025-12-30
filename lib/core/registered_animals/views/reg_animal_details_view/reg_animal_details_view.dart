import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/common/widgets/loading_overlay.dart';
import 'package:weqaa/core/registered_animals/providers/reg_animal_details_provider/reg_animal_details_provider.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';

class RegisteredAnimalDetailsView extends StatefulWidget {
  const RegisteredAnimalDetailsView({super.key, required this.id});

  final String id;

  @override
  State<RegisteredAnimalDetailsView> createState() =>
      _RegisteredAnimalDetailsViewState();
}

class _RegisteredAnimalDetailsViewState
    extends State<RegisteredAnimalDetailsView> {
  late RegisteredAnimalDetailsProvider provider;

  @override
  void initState() {
    provider =
        Provider.of<RegisteredAnimalDetailsProvider>(context, listen: false);
    Future.microtask(() {
      provider.fetchAnimalDetails(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisteredAnimalDetailsProvider>(
        builder: (context, value, child) {
      return LoadingOverlay(
          loading: false,
          backGroundColor: Colors.transparent,
          progressColor: kTextStyled,
          child: Scaffold(
            appBar: AppAppBar(
              title: "animal_details".tr(),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      R.assetsImagesCommonEditIcon,
                      width: 20,
                    ))
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              children: [
                buildIdWidget(provider.animal),
                20.vertical(),
                buildRow(
                    buildTitleValue(
                        "breed".tr(), provider.animal?.breed?.breed ?? ''),
                    buildTitleValue(
                        "age".tr(), "${provider.animal?.age ?? ''} Years")),
                buildDivider(),
                buildRow(
                    buildTitleValue("sex".tr(), provider.animal?.sex ?? ''),
                    buildTitleValue("facility_id".tr(),
                        provider.animal?.user?.facilityId ?? '')),
              ],
            ),
          ));
    });
  }

  Widget buildIdWidget(MyAnimalResponse? animal) {
    return Column(
      children: [
        Text(
          animal?.species?.name ?? '',
          style: kBody16PxRegular,
        ),
        4.vertical(),
        Text(
          "${"id_".tr()} ${animal?.id ?? ''}",
          style: kCaption14PxRegular.copyWith(color: kGrayText),
        ),
        12.vertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButtonIcon(
                R.assetsImagesTagIcon, "generate_tag".tr(), () {}),
            12.horizontal(),
            buildButtonIcon(
                R.assetsImagesCommonDownload, "download".tr(), () {}),
            12.horizontal(),
            buildButtonIcon(R.assetsImagesCommonQrCode, "qr_code".tr(), () {}),
          ],
        )
      ],
    );
  }

  Widget buildButtonIcon(String image, String title, VoidCallback onTap) {
    return Container(
      width: 100,
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
