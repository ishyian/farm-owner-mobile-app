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
import 'package:weqaa/utils/extensions/context.dart';
import 'package:weqaa/utils/extensions/num.dart';
import 'package:weqaa/utils/helpers/validators.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        buildLanguageDropDown(),
        24.vertical(),
        Text(
          "surveillance_system".tr(),
          style: kH524PxMedium.copyWith(color: kDarkPrimary),
        ),
        24.vertical(),
        Text(
          "login_with_your_credentials".tr(),
          style: kBody16PxRegular,
        ),
        24.vertical(),
        AppDropDownTextField(
          value: authProvider.loginUserType,
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
            if (val != null) {
              authProvider.loginUserType = val;
            }
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
            hint: "phone_number".tr(),
            controller: authProvider.loginPhoneController,
            inputAction: TextInputAction.done,
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
          enabled: authProvider.loginButtonEnabled ,
          title: "send_otp".tr(),
          onPressed:authProvider.sendLoginOTP,
          isLoading: authProvider.isLoading,
        ),
        16.vertical(),
        RichText(
          text: TextSpan(
            text: "${"not_member".tr()} ",
            style: kSmall12PxRegular.copyWith(color: kDisabledColor),
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = authProvider.navigateToRegister,
                text: "register_now".tr(),
                style: kSmall12PxBold.copyWith(color: kDarkPrimary),
              ),
            ],
          ),
        ),
        27.vertical()
      ],
    );
  }

  Widget buildLanguageDropDown() {
    return Align(
        alignment:
            context.isRTL() ? Alignment.centerLeft : Alignment.centerRight,
        child: const LanguageDropdown());
  }
}
