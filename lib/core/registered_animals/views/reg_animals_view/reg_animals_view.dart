import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/common/widgets/loading_overlay.dart';
import 'package:weqaa/core/registered_animals/providers/reg_animals_list_provider/reg_animal_list_provider.dart';
import 'package:weqaa/core/registered_animals/widgets/reg_animals_view/empty_reg_animals_view.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

import '../../../common/views/my_account_view/my_account_view.dart';
import '../../widgets/reg_animals_view/reg_animals_list.dart';
import '../reg_animal_form_view/reg_animal_form_view.dart';

class RegisteredAnimalsView extends StatefulWidget {
  const RegisteredAnimalsView({super.key});

  @override
  State<RegisteredAnimalsView> createState() => _RegisteredAnimalsViewState();
}

class _RegisteredAnimalsViewState extends State<RegisteredAnimalsView>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  bool isEmpty = false;

  late RegisteredAnimalListProvider provider;

  @override
  void initState() {
    provider =
        Provider.of<RegisteredAnimalListProvider>(context, listen: false);
    Future.microtask(() {
      provider.fetchAnimals();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisteredAnimalListProvider>(
        builder: (context, provider, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton.small(
            onPressed: () {
              locator<NavHelper>().push(const RegisteredAnimalFormView());
            },
            backgroundColor: kDarkPrimary,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          appBar: AppAppBar(
            showBackIcon: false,
            title: "registered_animals".tr(),
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
          body: LoadingOverlay(
            loading: provider.isLoading,
            backGroundColor: Colors.transparent,
            progressColor: kTextStyled,
            child: isEmpty
                ? const EmptyRegisteredAnimalsView()
                : Column(
                    children: [
                      Expanded(
                          child: RegisteredAnimalsList(
                              animalsList: provider.registeredAnimalsList))
                    ],
                  ),
          ));
    });
  }
}
