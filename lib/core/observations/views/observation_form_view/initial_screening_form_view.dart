import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:weqaa/api/model/home/disease_response.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/core/common/widgets/common/app_drop_down_text_field.dart';
import 'package:weqaa/core/common/widgets/common/app_multi_drop_down_text_field.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';
import 'package:weqaa/core/common/widgets/loading_overlay.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

import '../../providers/observation_form_provider/initial_screening_form_provider.dart';
import '../../widgets/observations_form_view/initial_screening_form_documents.dart';
import '../../widgets/observations_form_view/initial_screening_symptoms_files.dart';

class InitialScreeningFormView extends StatefulWidget {
  const InitialScreeningFormView({super.key});

  @override
  State<InitialScreeningFormView> createState() =>
      _InitialScreeningFormViewState();
}

class _InitialScreeningFormViewState extends State<InitialScreeningFormView> {
  late InitialScreeningFormProvider provider;

  @override
  void initState() {
    provider =
        Provider.of<InitialScreeningFormProvider>(context, listen: false);
    Future.microtask(() {
      provider.fetchCommonData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InitialScreeningFormProvider>(
      builder: (context, provider, child) {
        return Form(
          key: provider.formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Scaffold(
            appBar: AppAppBar(title: "add_initial_screening".tr()),
            body: LoadingOverlay(
                loading: provider.isLoading,
                backGroundColor: Colors.transparent,
                progressColor: kTextStyled,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        32.vertical(),
                        batchIdsDropDown(provider),
                        16.vertical(),
                        buildScreeningResult(provider),
                        16.vertical(),
                        buildSymptoms(provider),
                        16.vertical(),
                        Text(
                          "_symptoms".tr(
                            namedArgs: {
                              "count": "${provider.selectedSymptoms.length}",
                            },
                          ),
                          style: kSmall12PxRegular.copyWith(color: kGrayText),
                        ),
                        16.vertical(),
                        const InitialScreeningSymptomsFiles(),
                        buildDivider(),
                        buildDiseases(provider),
                        16.vertical(),
                        Text(
                          "_diseases".tr(
                            namedArgs: {
                              "count": "${provider.selectedDiseases.length}",
                            },
                          ),
                          style: kSmall12PxRegular.copyWith(color: kGrayText),
                        ),
                        16.vertical(),
                        buildDiseasesList(provider),
                        buildDivider(),
                        const InitialScreeningFormDocuments(),
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
                            title: "add_initial_screening".tr(),
                            onPressed: provider.submit),
                        32.vertical(),
                      ],
                    ),
                  ),
                )),
          ),
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

  AppDropDownTextField<String> batchIdsDropDown(
      InitialScreeningFormProvider provider) {
    return AppDropDownTextField(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.animalBatchId,
        validator: (item) {
          return provider.animalBatchId == null
              ? "this_field_is_required".tr()
              : null;
        },
        onChanged: (val) {
          provider.animalBatchId = val;
        },
        hint: "select_animal_batch_id".tr(),
        title: "animal_batch_id".tr(),
        items: provider.animals
            .map((item) => DropdownMenuItem(
                value: item.id,
                child: Text(
                  item.nickname ?? '',
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }

  AppMultiDropDownTextField<Symptom> buildSymptoms(
      InitialScreeningFormProvider provider) {
    return AppMultiDropDownTextField(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      selectedItems: provider.selectedSymptoms,
      validator: (items) {
        return (provider.selectedSymptoms.isEmpty)
            ? "this_field_is_required".tr()
            : null;
      },
      onChanged: (List<Symptom> values) {
        provider.selectedSymptoms = values;
      },
      hint: "select_symptoms".tr(),
      title: "symptoms".tr(),
      items: provider.symptoms
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.name ?? '',
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                ),
              ))
          .toList(),
    );
  }

  AppMultiDropDownTextField<Disease> buildDiseases(
      InitialScreeningFormProvider provider) {
    return AppMultiDropDownTextField(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      selectedItems: provider.selectedDiseases,
      validator: (items) {
        return (provider.selectedDiseases.isEmpty)
            ? "this_field_is_required".tr()
            : null;
      },
      onChanged: (List<Disease> values) {
        provider.selectedDiseases = values;
      },
      hint: "select_diseases".tr(),
      title: "diseases".tr(),
      items: provider.diseases
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.name ?? '',
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                ),
              ))
          .toList(),
    );
  }

  Widget buildScreeningResult(InitialScreeningFormProvider provider) {
    return AppDropDownTextField(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.screeningResult,
        validator: (item) {
          return provider.screeningResult == null
              ? "this_field_is_required".tr()
              : null;
        },
        onChanged: (val) {
          provider.screeningResult = val;
        },
        hint: "select_screening_result".tr(),
        title: "screening_result".tr(),
        items: provider.screeningResultList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }

  buildDiseasesList(InitialScreeningFormProvider provider) {
    return Wrap(
      children: [
        for (int i = 0; i < provider.selectedDiseases.length; i++)
          buildSingleDisease(provider, i),
      ],
    );
  }

  buildSingleDisease(InitialScreeningFormProvider provider, int i) {
    return Container(
      child: i == provider.selectedDiseases.length - 1
          ? Text(
              provider.selectedDiseases[i].name ?? '',
              style: kBody16PxRegular,
            )
          : Text(
              "${provider.selectedDiseases[i].name ?? ''}, ",
              style: kBody16PxRegular,
            ),
    );
  }
}
