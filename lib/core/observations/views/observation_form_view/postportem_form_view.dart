import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/core/common/widgets/common/app_drop_down_text_field.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';
import 'package:weqaa/core/common/widgets/common/cutome_radio_button.dart';
import 'package:weqaa/core/my_animals/providers/animal_form_provider/animal_form_provider.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

import '../../providers/observation_form_provider/postportem_form_provider.dart';
import 'animal_postportems_form.dart';

class PostportemFormView extends StatefulWidget {
  const PostportemFormView({super.key});

  @override
  State<PostportemFormView> createState() => _PostportemFormViewState();
}

class _PostportemFormViewState extends State<PostportemFormView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostportemFormProvider(),
      child: Consumer<PostportemFormProvider>(
        builder: (context, provider, child) {
          return Form(
            key: provider.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Scaffold(
              appBar: AppAppBar(title: "add_postmortem".tr()),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      32.vertical(),
                      buildPostportemDate(provider),
                      16.vertical(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "_no_of_animals_screened".tr(
                            namedArgs: {
                              "count": "${15}",
                            },
                          ),
                          textAlign: TextAlign.start,
                          style: kCaption14PxMedium.copyWith(color: Colors.black),
                        ),
                      ),
                      buildDivider(),
                      const AnimalPostportemsForm(),
                      24.vertical(),
                      AppButton(title: "submit".tr(), onPressed: provider.submit),
                      32.vertical(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppTextField buildBreedTextField(AnimalFormProvider provider) {
    return AppTextField(
      controller: provider.breedController,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      title: "breed".tr(),
      hint: "breed_of_animal".tr(),
      validator: qValidator([Validators.isRequired()]),
    );
  }

  Column buildAnimalOrgansCollectedTextField(PostportemFormProvider provider) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "no_animals_organs_collected".tr(),
              style: kSmall12PxRegular,
            ),
            16.horizontal(),
            GestureDetector(
              onTap: () {
                provider.addAnimalPostmortem();
              },
              child: Container(
                width: 64,
                decoration: const ShapeDecoration(shape: StadiumBorder(), color: kPrimary100),
                padding: const EdgeInsets.all(6),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        color: kPrimary500,
                        size: 14,
                      ),
                      6.horizontal(),
                      Text(
                        "add".tr(),
                        style: kSmall12PxRegular,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        8.vertical(),
        AppTextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          readOnly: true,
          textInputType: TextInputType.number,
          controller: provider.animalOrgansCollectedController,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          // title: "no_animals_organs_collected".tr(),
          hint: "no_animals_organs_collected".tr(),
          validator: qValidator([Validators.isRequired()]),
        )
      ],
    );
  }

  AppTextField buildPostportemDate(PostportemFormProvider provider) {
    return AppTextField(
      controller: provider.postportemDateController,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      title: "date_of_post_mortem".tr(),
      hint: "select_post_mortem_date".tr(),
      readOnly: true,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              provider.postportemDateController.text =
                  DateFormat("yyyy-MM-dd").format(DateTime.now());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Icon(Icons.calendar_month_outlined),
            ),
          ),
        ],
      ),
      validator: qValidator([Validators.isRequired()]),
    );
  }

  Widget buildIsIndividual(AnimalFormProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "add_individual_or_batch".tr(),
          style: kCaption14PxRegular.copyWith(color: kGrayText),
        ),
        8.vertical(),
        Row(
          children: [
            CustomRadioButton<bool>(
                value: true,
                groupValue: provider.isIndividual,
                onChanged: (val) {
                  provider.setIsIndividual(val!);
                },
                title: "individual".tr()),
            32.horizontal(),
            CustomRadioButton<bool>(
                value: false,
                groupValue: provider.isIndividual,
                onChanged: (val) {
                  provider.setIsIndividual(val!);
                },
                title: "batch".tr())
          ],
        ),
        buildDivider()
      ],
    );
  }

  Widget buildSex(AnimalFormProvider provider) {
    return FormField<String?>(
      validator: (val) {
        return provider.sex == null ? "this_field_is_required".tr() : null;
      },
      builder: (FormFieldState<String?> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "sex".tr(),
              style: kSmall12PxRegular,
            ),
            8.vertical(),
            Row(
              children: provider.sexList.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: CustomRadioButton<String?>(
                    value: e,
                    groupValue: provider.sex,
                    onChanged: (val) {
                      provider.setSex(val!);
                      state.didChange(val);
                    },
                    title: e,
                  ),
                );
              }).toList(),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: kErrorColor,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 0.2,
      color: const Color(0xff1F2024).withOpacity(0.5),
    );
  }

  AppDropDownTextField<String> speciesDropdown(AnimalFormProvider provider) {
    return AppDropDownTextField(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.species,
        validator: (item) {
          return provider.species == null ? "this_field_is_required".tr() : null;
        },
        onChanged: (val) {
          provider.species = val;
        },
        hint: "select_species".tr(),
        title: "species".tr(),
        items: provider.speciesList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }

  AppDropDownTextField<String> breedDropDown(AnimalFormProvider provider) {
    return AppDropDownTextField(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.breed,
        validator: (item) {
          return provider.breed == null ? "this_field_is_required".tr() : null;
        },
        onChanged: (val) {
          provider.breed = val;
        },
        hint: "select_breed".tr(),
        title: "breed".tr(),
        items: provider.breedList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }

  Widget buildAnimalStatus(AnimalFormProvider provider) {
    return AppDropDownTextField(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.animalStatus,
        validator: (item) {
          return provider.animalStatus == null ? "this_field_is_required".tr() : null;
        },
        onChanged: (val) {
          provider.animalStatus = val;
        },
        hint: "select_animal_status".tr(),
        title: "animal_status".tr(),
        items: provider.animalStatusList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }
}
