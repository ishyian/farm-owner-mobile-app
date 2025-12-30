import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/auth/providers/auth_provider/auth_provider.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/core/common/widgets/common/app_drop_down_text_field.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';
import 'package:weqaa/core/common/widgets/common/lanugages_dropdown.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        24.vertical(),
        Text(
          "surveillance_system".tr(),
          style: kH524PxMedium.copyWith(color: kDarkPrimary),
        ),
        24.vertical(),
        Text(
          "create_an_account_to_continue".tr(),
          style: kBody16PxRegular,
        ),
        24.vertical(),
        AppDropDownTextField(
          value: authProvider.registerUserType,
          hint: "select_user_type".tr(),
          items: authProvider.userTypes
              .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(
                      type,
                      style: kBody16PxRegular.copyWith(color: Colors.black),
                    ),
                  ))
              .toList(),
          onChanged: (val) {
            authProvider.registerUserType = val;
          },
        ),
        16.vertical(),
        Directionality(
          textDirection: TextDirection.ltr,
          child: AppTextField(
            onChanged: (val) {
              authProvider.formKey.currentState?.validate();
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            hint: "mobile_number".tr(),
            inputAction: TextInputAction.done,
            controller: authProvider.registerPhoneController,
            validator:
                qValidator([Validators.isRequired(), Validators.phoneNumber()]),
            textInputType: TextInputType.phone,
            prefix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("+966",
                      style: kBody16PxRegular.copyWith(color: kHintColor)),
                ),
              ],
            ),
          ),
        ),
        32.vertical(),
        AppButton(
          enabled: authProvider.registerButtonEnabled,
          title: "send_otp".tr(),
          onPressed: authProvider.sendRegisterOTP,
          isLoading: authProvider.isLoading,
        ),
        16.vertical(),
        RichText(
          text: TextSpan(
            text: "${"already_member".tr()} ",
            style: kSmall12PxRegular.copyWith(color: kDisabledColor),
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = authProvider.navigateToLogin,
                text: "login".tr(),
                style: kSmall12PxBold.copyWith(color: kPrimaryColor),
              ),
            ],
          ),
        ),
        27.vertical()
      ],
    );
  }

  Widget buildLanguageDropDown() {
    return const Align(
        alignment: Alignment.centerRight, child: LanguageDropdown());
  }
}
