import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';
import 'package:weqaa/core/common/widgets/common/cached_image.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';
import 'package:weqaa/utils/helpers/ui_helper.dart';

import '../../views/reg_animal_details_view/reg_animal_details_view.dart';

class RegisteredAnimalsList extends StatefulWidget {
  const RegisteredAnimalsList({super.key, required this.animalsList});

  final List<MyAnimalResponse> animalsList;

  @override
  State<RegisteredAnimalsList> createState() => _RegisteredAnimalsListState();
}

class _RegisteredAnimalsListState extends State<RegisteredAnimalsList> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppTextField(
            controller: searchController,
            borderRadius: 50,
            fillColor: const Color(0xFFF8F9FE),
            hint: "search".tr(),
            prefix: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffix: InkWell(
              onTap: () {
                locator.get<UiHelper>().showSnackBar("show qrcode scanner");
              },
              child: const Icon(
                Icons.qr_code,
                color: kPrimaryColor,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: widget.animalsList.length,
                  itemBuilder: (_, index) {
                    return buildWidgetRegAnimalList(widget.animalsList[index]);
                  }))
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget buildWidgetRegAnimalList(MyAnimalResponse animal) {
    return GestureDetector(
      onTap: () => locator<NavHelper>()
          .push(RegisteredAnimalDetailsView(id: animal.id.toString())),
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(16)),
              child: getAnimalImage(animal),
            ),
            16.horizontal(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animal.species?.name.toString() ?? "",
                    style: kBody16PxMedium.copyWith(color: Colors.black),
                  ),
                  4.vertical(),
                  Text(
                    animal.nickname.toString(),
                    style: kSmall12PxRegular.copyWith(color: kGrayText),
                  ),
                  4.vertical(),
                  Text(
                    "${animal.age} years",
                    style: kSmall12PxRegular.copyWith(color: kGrayText),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: kGrayText,
            ),
            16.horizontal()
          ],
        ),
      ),
    );
  }

  Widget getAnimalImage(MyAnimalResponse animal) {
    if (animal.images?.isEmpty ?? true) {
      return getPlaceholderAnimalImage();
    } else {
      return CachedImage(
        url: animal.images?.first.url.toString(),
        errorWidget: getPlaceholderAnimalImage(),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      );
    }
  }

  Widget getPlaceholderAnimalImage() {
    return Image.asset(
      R.assetsImagesPlaceHolder,
      width: 80,
      height: 80,
    );
  }
}
