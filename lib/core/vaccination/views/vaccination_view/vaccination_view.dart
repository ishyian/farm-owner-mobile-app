import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/views/alerts_view/alerts_view.dart';
import 'package:weqaa/core/common/views/my_account_view/my_account_view.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/vaccination/views/vaccination_list/vaccination_list.dart';
import 'package:weqaa/core/vaccination/widgets/vaccination_view/empty_vaccination_view.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class VaccinationView extends StatefulWidget {
  const VaccinationView({super.key});

  @override
  State<VaccinationView> createState() => _VaccinationViewState();
}

class _VaccinationViewState extends State<VaccinationView>
    with SingleTickerProviderStateMixin {
  final tabs = ["upcoming".tr(), "overdue".tr(), "completed".tr()];

  late final TabController tabController;
  int currentIndex = 0;

  bool isEmpty = false;
  @override
  void initState() {
    tabController =
        TabController(length: 2, vsync: this, initialIndex: currentIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        showBackIcon: false,
        title: "vaccination".tr(),
        actions: [
          IconButton(
            onPressed: () {
              locator<NavHelper>().push(AlertsView());
            },
            icon: Image.asset(
              R.assetsImagesCommonNotifications,
              width: 18,
            ),
          ),
          IconButton(
            onPressed: () {
              locator<NavHelper>().push(const MyAccountView());
            },
            icon: Image.asset(
              R.assetsImagesCommonProfileIcon,
              width: 20,
            ),
          )
        ],
      ),
      body: isEmpty
          ? const EmptyVaccinationView()
          : Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(4),
                    child:
                        Row(children: tabs.map((e) => buildTab(e)).toList())),
                const Expanded(child: VaccinationList()),
              ],
            ),
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: selected ? Colors.white : null),
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
