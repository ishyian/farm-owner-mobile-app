import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/auth/providers/complete_profile_provider/complete_profile_provider.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/core/common/widgets/common/app_drop_down_text_field.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';
import 'package:weqaa/core/common/widgets/common/cutome_radio_button.dart';
import 'package:weqaa/core/common/widgets/loading_overlay.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

class CompleteProfileView extends StatefulWidget {

  final String usertypeId;
  final String mobile;
  const CompleteProfileView({super.key, required this.mobile, required this.usertypeId});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CompleteProfileProvider(),
        child: Consumer<CompleteProfileProvider>(
          builder: (context, provider, child) {
            return LoadingOverlay(
              loading: provider.loading,
              child: Form(
                key: provider.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Scaffold(
                  body: SafeArea(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 40),
                      children: [
                        buildTitle(),
                        24.vertical(),
                        buildFacitlityIdQuestion(provider),
                        16.vertical(),
                        const Divider(
                          thickness: 0.3,
                        ),
                        16.vertical(),
                        if (provider.haveFacilityId)
                          facilityIdDropDown(provider)
                        else
                          AppTextField(
                            controller: provider.facilityIdController,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            title: "facility".tr(),
                            hint: "facility".tr(),
                            validator: qValidator([Validators.isRequired()]),
                          ),
                        16.vertical(),
                        AppTextField(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          title: "farm_name".tr(),
                          hint: "farm_name".tr(),
                          controller: provider.farmNameController,
                          validator: qValidator([Validators.isRequired()]),
                        ),
                        16.vertical(),
                        AppTextField(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          title: "owner_name".tr(),
                          hint: "owner_name".tr(),
                          controller: provider.ownerNameController,
                          validator: qValidator([Validators.isRequired()]),
                        ),
                        16.vertical(),
                        AppTextField(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          title: "national_id".tr(),
                          hint: "your_national_id".tr(),
                          controller: provider.nationalIdController,
                          validator: qValidator([Validators.isRequired()]),
                        ),
                        16.vertical(),
                        AppTextField(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          title: "location_manual".tr(),
                          hint: "your_location".tr(),
                          controller: provider.locationManuallyController,
                          validator: qValidator([Validators.isRequired()]),
                        ),
                        16.vertical(),
                        AppTextField(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          title: "location".tr(),
                          hint: "latitude_longitude".tr(),
                          readOnly: true,
                          suffix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: provider.getLocation,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Text("get".tr(),
                                      style: kBody16PxRegular.copyWith(
                                          color: kHintColor)),
                                ),
                              ),
                            ],
                          ),
                          controller: provider.locationLatitudeLabelController,
                          validator: qValidator([Validators.isRequired()]),
                        ),
                        24.vertical(),
                        AppButton(
                            title: "submit".tr(),
                            onPressed: ()=> provider.submit(widget.mobile, widget.usertypeId),
                          isLoading: provider.isApiLoading,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  AppDropDownTextField<String> facilityIdDropDown(
      CompleteProfileProvider provider) {
    return AppDropDownTextField(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: provider.facilityId,
        validator: (item) {
          return provider.facilityId == null
              ? "this_field_is_required".tr()
              : null;
        },
        onChanged: (val) {
          provider.facilityId = val;
        },
        hint: "select_facility_id".tr(),
        title: "select_facility_id".tr(),
        items: provider.facilities
            .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: kBody16PxRegular.copyWith(color: Colors.black),
                )))
            .toList());
  }

  Text buildTitle() {
    return Text(
      "complete_your_profile".tr(),
      style: kBody16PxRegular.copyWith(color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  Widget buildFacitlityIdQuestion(CompleteProfileProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "do_you_have_facility_id".tr(),
          style: kCaption14PxRegular.copyWith(color: kGrayText),
        ),
        8.vertical(),
        Row(
          children: [
            CustomRadioButton<bool>(
                value: true,
                groupValue: provider.haveFacilityId,
                onChanged: (val) {
                  provider.haveFacilityId = val!;
                },
                title: "yes".tr()),
            32.horizontal(),
            CustomRadioButton<bool>(
                value: false,
                groupValue: provider.haveFacilityId,
                onChanged: (val) {
                  provider.haveFacilityId = val!;
                },
                title: "no".tr())
          ],
        )
      ],
    );
  }
}
