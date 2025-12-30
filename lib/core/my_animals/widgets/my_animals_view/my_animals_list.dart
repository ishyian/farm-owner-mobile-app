import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';
import 'package:weqaa/core/common/widgets/common/cached_image.dart';
import 'package:weqaa/core/my_animals/views/animal_details_view/animal_details_view.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class MyAnimalsList extends StatefulWidget {
  const MyAnimalsList({super.key, required this.isIndividual , required this.animalsList});
  final bool isIndividual;
  final List<MyAnimalResponse> animalsList;
  @override
  State<MyAnimalsList> createState() => _MyAnimalsListState();
}

class _MyAnimalsListState extends State<MyAnimalsList> {
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
            hint: "search".tr(),
            prefix: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: widget.animalsList.length,
                  itemBuilder: (_, index) {
                    return buildWidget(index);
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

  Widget buildWidget(int index) {
    final animal = widget.animalsList[index];

    return GestureDetector(
      onTap: () => locator<NavHelper>().push(AnimalDetailsView(animal: animal)),
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
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.asset(
                R.assetsImagesPlaceHolder,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            16.horizontal(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animal.species!.name ?? "Unknown" ,
                    style: kBody16PxMedium.copyWith(color: Colors.black),
                  ),
                  4.vertical(),
                  Text(
                    animal.nickname ?? "No nickname",
                    style: kSmall12PxRegular.copyWith(color: kGrayText),
                  ),
                  4.vertical(),
                  Text(
                    "${animal.age.toString()} years",
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
}
