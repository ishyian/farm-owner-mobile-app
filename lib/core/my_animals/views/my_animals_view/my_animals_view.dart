import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/views/alerts_view/alerts_view.dart';
import 'package:weqaa/core/common/views/my_account_view/my_account_view.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/my_animals/providers/animal_list_provider/animal_list_provider.dart';
import 'package:weqaa/core/my_animals/views/animal_form_view/animal_form_view.dart';
import 'package:weqaa/core/my_animals/widgets/my_animals_view/empty_animals_view.dart';
import 'package:weqaa/core/my_animals/widgets/my_animals_view/my_animals_list.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class MyAnimalsView extends StatefulWidget {
  const MyAnimalsView({super.key});

  @override
  State<MyAnimalsView> createState() => _MyAnimalsViewState();
}

class _MyAnimalsViewState extends State<MyAnimalsView> with SingleTickerProviderStateMixin {
  final tabs = ["individual".tr(), "batch".tr()];

  late final TabController tabController;
  late AnimalListProvider provider;
  int currentIndex = 0;

  @override
  void initState() {
    provider = Provider.of<AnimalListProvider>(context, listen: false);
    Future.microtask(() {
      fetchCurrentList();
    });
    tabController = TabController(length: 2, vsync: this, initialIndex: currentIndex);
    super.initState();
  }

  void fetchCurrentList() {
    if (currentIndex == 0) {
      provider.fetchIndividualAnimalsList();
    } else {
      provider.fetchBatchAnimalsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalListProvider>(
      builder: (BuildContext context, provider, Widget? child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.small(
            onPressed: () {
              locator<NavHelper>().push(AnimalFormView(isIndividual: currentIndex == 0));
            },
            backgroundColor: kDarkPrimary,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          appBar: AppAppBar(
            showBackIcon: false,
            title: "my_animals".tr(),
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
                icon: Center(
                  child: Image.asset(
                    R.assetsImagesCommonProfileIcon,
                    width: 20,
                  ),
                ),
              )
            ],
          ),
          body: provider.visible
              ? provider.isListEmpty(currentIndex == 0)
                  ? const EmptyAnimalsView()
                  : Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xffF3F3F3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Row(children: tabs.map((e) => buildTab(e)).toList())),
                        Expanded(
                            child: MyAnimalsList(
                          isIndividual: currentIndex == 0,
                          animalsList: provider.getCurrentList(currentIndex == 0),
                        )),
                      ],
                    )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  Widget buildTab(String e) {
    final selected = tabs.indexOf(e) == currentIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = tabs.indexOf(e);
            fetchCurrentList();
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
