import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/views/alerts_view/alerts_view.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/observations/views/observation_form_view/initial_screening_form_view.dart';
import 'package:weqaa/core/observations/views/observation_form_view/postportem_form_view.dart';
import 'package:weqaa/core/observations/widgets/observation_view/empty_observation_view.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

import '../../../common/views/my_account_view/my_account_view.dart';
import '../../widgets/observation_view/observation_list.dart';

class ObservationsView extends StatefulWidget {
  const ObservationsView({super.key});

  @override
  State<ObservationsView> createState() => _ObservationsViewState();
}

class _ObservationsViewState extends State<ObservationsView> with SingleTickerProviderStateMixin {
  final tabs = ["initial_screening".tr(), "post_postmortem".tr()];

  late final TabController tabController;
  int currentIndex = 0;

  bool isEmpty = false;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: currentIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          locator<NavHelper>().push(currentIndex == 0 ? const InitialScreeningFormView() : const PostportemFormView());
        },
        backgroundColor: kDarkPrimary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppAppBar(
        showBackIcon: false,
        title: "observations".tr(),
        actions: [
          IconButton(
            onPressed: () {
              locator<NavHelper>().push(const MyAccountView());
            },
            icon: Center(
              child: Image.asset(
                R.assetsImagesCommonProfileIcon,
                width: 20,
              ),
            ),
          )
        ],
      ),
      body: Column(children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xffF3F3F3),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(4),
            child: Row(children: tabs.map((e) => buildTab(e)).toList())),
        isEmpty
            ? Expanded(
                child: EmptyObservationView(
                  isInitialScreening: currentIndex == 0,
                ),
              )
            : Expanded(
                child: Column(
                  children: [
                    Expanded(
                        child: ObservationList(
                      isInitialScreening: currentIndex == 0,
                    )),
                  ],
                ),
              ),
      ]),
    );
  }

  Widget buildTab(String e) {
    final selected = tabs.indexOf(e) == currentIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = tabs.indexOf(e);
          });
        },
        child: AnimatedContainer(
          height: 40,
          width: double.infinity,
          duration: kThemeAnimationDuration,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: selected ? Colors.white : null),
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              e,
              style: selected
                  ? kCaption14PxMedium.copyWith(color: Colors.black)
                  : kCaption14PxRegular.copyWith(color: kGrayText),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
