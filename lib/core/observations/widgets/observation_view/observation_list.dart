import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/cached_image.dart';
import 'package:weqaa/core/common/widgets/loading_overlay.dart';
import 'package:weqaa/core/observations/providers/initial_screening_list_provider/initial_screening_list_provider.dart';
import 'package:weqaa/core/observations/widgets/observation_view/post_mortem_item.dart';
import 'package:weqaa/core/registered_animals/views/reg_animals_view/reg_animals_view.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

import 'initial_screening_item.dart';

class ObservationList extends StatefulWidget {
  const ObservationList({super.key, required this.isInitialScreening});

  final bool isInitialScreening;

  @override
  State<ObservationList> createState() => _ObservationListState();
}

class _ObservationListState extends State<ObservationList> {
  late ObservationListProvider provider;

  @override
  void initState() {
    provider = Provider.of<ObservationListProvider>(context, listen: false);
    Future.microtask(() {
      provider.fetchAnimalScreeningList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ObservationListProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return LoadingOverlay(
          loading: provider.isLoading,
          backGroundColor: Colors.transparent,
          progressColor: kTextStyled,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Expanded(
              child: ListView.builder(
                itemCount: widget.isInitialScreening
                    ? provider.animalScreenings.length
                    : provider.postMortems.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (_, index) {
                  return widget.isInitialScreening
                      ? InitialScreeningItem(
                          index: index,
                          animalScreening: provider.animalScreenings[index])
                      : PostmortemItem(
                          index: index,
                          postMortem: provider.postMortems[index]);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildWidget(int index) {
    return GestureDetector(
      onTap: () => locator<NavHelper>().push(const RegisteredAnimalsView()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
              child: CachedImage(
                url:
                    "https://images.pexels.com/photos/1996333/pexels-photo-1996333.jpeg",
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
                    "Horse",
                    style: kBody16PxMedium.copyWith(color: Colors.black),
                  ),
                  4.vertical(),
                  Text(
                    "Bulbul",
                    style: kSmall12PxRegular.copyWith(color: kGrayText),
                  ),
                  4.vertical(),
                  Text(
                    "2 years",
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
