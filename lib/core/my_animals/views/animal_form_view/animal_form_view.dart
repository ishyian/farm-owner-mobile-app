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
import 'package:weqaa/core/my_animals/widgets/animal_form_view/animal_form_documents.dart';
import 'package:weqaa/core/my_animals/widgets/animal_form_view/animal_form_vaccinations.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

class AnimalFormView extends StatefulWidget {
  const AnimalFormView({super.key, required this.isIndividual});
  final bool isIndividual;

  @override
  State<AnimalFormView> createState() => _AnimalFormViewState();
}

class _AnimalFormViewState extends State<AnimalFormView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          AnimalFormProvider()..setIsIndividual(widget.isIndividual),
      child: Consumer<AnimalFormProvider>(
        builder: (context, provider, child) {
          return Form(
            key: provider.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Scaffold(
              appBar: AppAppBar(title: "add_animal".tr()),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      32.vertical(),
                      buildIsIndividual(provider),
                      speciesDropdown(provider),
                      16.vertical(),
                      if (provider.isIndividual)
                        buildBreedTextField(provider)
                      else
                        breedDropDown(provider),
                      16.vertical(),
                      if (!provider.isIndividual) ...[
                        AppTextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textInputType: TextInputType.number,
                          controller: provider.numberOfAnimalsController,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          title: "number_of_animals".tr(),
                          hint: "number_of_animals".tr(),
                          validator: qValidator([Validators.isRequired()]),
                        ),
                        16.vertical()
                      ],
                      buildAgeTextField(provider),
                      16.vertical(),
                      buildSex(provider),
                      if (provider.isIndividual) ...[
                        16.vertical(),
                        AppTextField(
                          controller: provider.nickNameController,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          title: "nick_name".tr(),
                          hint: "animal_nick_name".tr(),
                          validator: qValidator([Validators.isRequired()]),
                        ),
                        16.vertical(),
                        buildEarTag(provider),
                        16.vertical(),
                        buildAnimalStatus(provider),
                      ],
                      buildDivider(),
                      const AnimalFormVaccinations(),
                      buildDivider(),
                      const AnimalFormDocuments(),
                      buildDivider(),
                      AppTextField(
                        controller: provider.remarksController,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        title: "remarks".tr(),
                        hint: "remarks".tr(),
                        validator: qValidator([Validators.isRequired()]),
                        minLines: 5,
                        maxLines: 5,
                        inputAction: TextInputAction.newline,
                        textInputType: TextInputType.multiline,
                      ),
                      24.vertical(),
                      AppButton(
                          title: "submit".tr(), onPressed: provider.submit),
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

  AppTextField buildAgeTextField(AnimalFormProvider provider) {
    return AppTextField(
      inputFormatters: provider.isIndividual
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : null,
      textInputType:
          provider.isIndividual ? TextInputType.number : TextInputType.text,
      controller: provider.ageController,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      title: provider.isIndividual ? "age".tr() : "age_group".tr(),
      hint: provider.isIndividual ? "age_of_animal".tr() : "age_group".tr(),
      validator: qValidator([Validators.isRequired()]),
    );
  }

  AppTextField buildEarTag(AnimalFormProvider provider) {
    return AppTextField(
      controller: provider.earTagController,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      title: "ear_tag".tr(),
      hint: "tag_number".tr(),
      readOnly: true,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              provider.earTagController.text =
                  DateFormat("dd/MM/yyyy").add_jms().format(DateTime.now());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("scan".tr(),
                  style: kBody16PxRegular.copyWith(color: kHintColor)),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.species,
        validator: (item) {
          return provider.species == null
              ? "this_field_is_required".tr()
              : null;
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.animalStatus,
        validator: (item) {
          return provider.animalStatus == null
              ? "this_field_is_required".tr()
              : null;
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
