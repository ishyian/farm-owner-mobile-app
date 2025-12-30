import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';
import 'package:weqaa/core/observations/providers/observation_form_provider/postportem_form_provider.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

import '../../../common/widgets/common/app_drop_down_text_field.dart';
import '../../../common/widgets/common/cutome_radio_button.dart';

class AnimalPostportemsForm extends StatefulWidget {
  const AnimalPostportemsForm({super.key});

  @override
  State<AnimalPostportemsForm> createState() => _AnimalPostportemsFormState();
}

class _AnimalPostportemsFormState extends State<AnimalPostportemsForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostportemFormProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(provider),
            for (int i = 0; i < provider.postmortemModels.length; i++)
              _SinglePostportemWidget(
                i,
                key: UniqueKey(),
              )
          ],
        );
      },
    );
  }

  Column buildHeader(PostportemFormProvider provider) {
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
}

class _SinglePostportemWidget extends StatefulWidget {
  const _SinglePostportemWidget(this.index, {super.key});

  final int index;

  @override
  State<_SinglePostportemWidget> createState() => _SinglePostportemWidgetState();
}

class _SinglePostportemWidgetState extends State<_SinglePostportemWidget> {
  final animalBatchIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PostportemFormProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            8.vertical(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: buildAnimalBatchIdTag(provider)),
                8.horizontal(),
                GestureDetector(
                  onTap: () => provider.removeVaccination(widget.index),
                  child: Container(
                    width: 45,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: kCancelColor),
                    child: const Icon(
                      Icons.remove,
                      color: kAlertError,
                    ),
                  ),
                )
              ],
            ),
            16.vertical(),
            examinedOrgansDropdown(provider),
            16.vertical(),
            examinedObservationsDropdown(provider),
            16.vertical(),
            buildCarcassCondemnation(provider),
            if (widget.index != provider.postmortemModels.length - 1) buildDivider(),
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

  AppTextField buildAnimalBatchIdTag(PostportemFormProvider provider) {
    return AppTextField(
      controller: animalBatchIdController,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      title: "animal_batch_id".tr(),
      hint: "select_animal_batch_id".tr(),
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              animalBatchIdController.text =
                  DateFormat("dd/MM/yyyy").format(DateTime.now());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("scan".tr(), style: kBody16PxRegular.copyWith(color: kHintColor)),
            ),
          ),
        ],
      ),
      validator: qValidator([Validators.isRequired()]),
      onChanged: (val) {
        provider.postmortemModels[widget.index].animalBatchId = val;
      },
    );
  }

  AppDropDownTextField<String> examinedOrgansDropdown(PostportemFormProvider provider) {
    return AppDropDownTextField(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.postmortemModels[widget.index].examinedOrgan,
        validator: (item) {
          return provider.postmortemModels[widget.index].examinedOrgan == null ? "this_field_is_required".tr() : null;
        },
        onChanged: (val) {
          provider.postmortemModels[widget.index].examinedOrgan = val;
        },
        hint: "select_examined_organ".tr(),
        title: "examined_organ".tr(),
        items: provider.examinedOrgansList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }

  AppDropDownTextField<String> examinedObservationsDropdown(PostportemFormProvider provider) {
    return AppDropDownTextField(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.postmortemModels[widget.index].observation,
        validator: (item) {
          return provider.postmortemModels[widget.index].observation == null ? "this_field_is_required".tr() : null;
        },
        onChanged: (val) {
          provider.postmortemModels[widget.index].observation = val;
        },
        hint: "select_observation".tr(),
        title: "observation_caps".tr(),
        items: provider.observationsList
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }

  Widget buildCarcassCondemnation(PostportemFormProvider provider) {
    return FormField<String?>(
      validator: (val) {
        return provider.postmortemModels[widget.index].carcassCondemnation == null
            ? "this_field_is_required".tr()
            : null;
      },
      builder: (FormFieldState<String?> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "carcass_condemnation".tr(),
              style: kSmall12PxRegular,
            ),
            8.vertical(),
            Row(
              children: provider.carcassCondemnationList.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: CustomRadioButton<String?>(
                    value: e,
                    groupValue: provider.postmortemModels[widget.index].carcassCondemnation,
                    onChanged: (val) {
                      provider.postmortemModels[widget.index].carcassCondemnation = val!;
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

  @override
  void dispose() {
    animalBatchIdController.dispose();
    super.dispose();
  }
}
