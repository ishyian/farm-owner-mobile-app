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
import 'package:weqaa/core/common/widgets/loading_overlay.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

import '../../providers/reg_animal_form_provider/reg_animal_form_provider.dart';

class RegisteredAnimalFormView extends StatefulWidget {
  const RegisteredAnimalFormView({super.key});

  @override
  State<RegisteredAnimalFormView> createState() =>
      _RegisteredAnimalFormViewState();
}

class _RegisteredAnimalFormViewState extends State<RegisteredAnimalFormView> {
  late RegisteredAnimalFormProvider provider;

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisteredAnimalFormProvider>(
      builder: (context, provider, child) {
        return LoadingOverlay(
          loading: provider.isLoading,
          child: Form(
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
                      speciesDropdown(provider),
                      16.vertical(),
                      breedDropDown(provider),
                      16.vertical(),
                      buildAgeTextField(provider),
                      16.vertical(),
                      buildSex(provider),
                      16.vertical(),
                      buildFacilityIdAutocompleteTextField(provider),
                      24.vertical(),
                      AppButton(
                          title: "scan_and_generate_tag".tr(),
                          onPressed: provider.scanAndGenerateTag),
                      32.vertical(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    provider =
        Provider.of<RegisteredAnimalFormProvider>(context, listen: false);
    Future.microtask(() {
      provider.fetchCommonData();
    });
    super.initState();
  }

  AppDropDownTextField<String> breedDropDown(
      RegisteredAnimalFormProvider provider) {
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
                value: item.id,
                child: Text(
                  item.breed.toString(),
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }

  AppTextField buildAgeTextField(RegisteredAnimalFormProvider provider) {
    return AppTextField(
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textInputType: TextInputType.number,
      controller: provider.ageController,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      title: "age".tr(),
      hint: "age_of_animal".tr(),
      validator: qValidator([Validators.isRequired()]),
    );
  }

  AppTextField buildFacilityIdTextField(RegisteredAnimalFormProvider provider) {
    return AppTextField(
      textInputType: TextInputType.text,
      controller: provider.facilityIdController,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      title: "facility_id".tr(),
      hint: "enter_facility_id".tr(),
      validator: qValidator([Validators.isRequired()]),
    );
  }

  Autocomplete<String> buildFacilityIdAutocompleteTextField(
      RegisteredAnimalFormProvider provider) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.length < 2) {
          return const Iterable<String>.empty();
        }
        return provider.getFacilitySuggestions(textEditingValue.text);
      },
      onSelected: (String selection) {
        provider.facilityIdController.text = selection;
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted,) {
        return AppTextField(
          textInputType: TextInputType.text,
          controller: fieldTextEditingController,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          title: "facility_id".tr(),
          hint: "enter_facility_id".tr(),
          focusNode: fieldFocusNode,
          validator: qValidator([Validators.isRequired()]),
        );
      },
    );
  }

  Widget buildSex(RegisteredAnimalFormProvider provider) {
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

  AppDropDownTextField<String> speciesDropdown(
      RegisteredAnimalFormProvider provider) {
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
                value: item.id,
                child: Text(
                  item.name.toString(),
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }
}
