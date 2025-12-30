import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_app_bar.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/core/common/widgets/common/app_drop_down_text_field.dart';
import 'package:weqaa/core/common/widgets/common/app_multi_drop_down_text_field.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';
import 'package:weqaa/core/incidients/providers/incident_form_provider/incident_form_provider.dart';
import 'package:weqaa/core/incidients/widgets/incident_form_view/incident_form_documents.dart';
import 'package:weqaa/core/incidients/widgets/incident_form_view/incident_symptoms_files.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

class IncidentFormView extends StatefulWidget {
  const IncidentFormView({super.key});

  @override
  State<IncidentFormView> createState() => _IncidentFormViewState();
}

class _IncidentFormViewState extends State<IncidentFormView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncidentFormProvider(),
      child: Consumer<IncidentFormProvider>(
        builder: (context, provider, child) {
          return Form(
            key: provider.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Scaffold(
              appBar: AppAppBar(title: "add_incident".tr()),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      32.vertical(),
                      batchIdsDropDown(provider),
                      16.vertical(),
                      buildAnimalStatus(provider),
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
                      const IncidentSymptomsFiles(),
                      buildDivider(),
                      const IncidentFormDocuments(),
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
                          title: "report_incident".tr(),
                          onPressed: provider.submit),
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

  Widget buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 0.2,
      color: const Color(0xff1F2024).withOpacity(0.5),
    );
  }

  AppDropDownTextField<String> batchIdsDropDown(IncidentFormProvider provider) {
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
        items: provider.animalBatchIds
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }

  AppMultiDropDownTextField<String> buildSymptoms(
      IncidentFormProvider provider) {
    return AppMultiDropDownTextField(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      selectedItems: provider.selectedSymptoms,
      validator: (items) {
        return (provider.selectedSymptoms.isEmpty)
            ? "this_field_is_required".tr()
            : null;
      },
      onChanged: (List<String> values) {
        provider.selectedSymptoms = values;
      },
      hint: "select_symptoms".tr(),
      title: "symptoms".tr(),
      items: provider.symptoms
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                ),
              ))
          .toList(),
    );
  }

  Widget buildAnimalStatus(IncidentFormProvider provider) {
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
