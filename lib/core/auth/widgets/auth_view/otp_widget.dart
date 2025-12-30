import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/auth/enums/auth_view_enums.dart';
import 'package:weqaa/core/auth/providers/auth_provider/auth_provider.dart';
import 'package:weqaa/core/common/widgets/common/app_button.dart';
import 'package:weqaa/core/common/widgets/common/app_outlined_button.dart';
import 'package:weqaa/core/common/widgets/common/lanugages_dropdown.dart';
import 'package:weqaa/utils/extensions/num.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        if (authProvider.previousSate == AuthViewEnum.login)
          buildLanguageDropDown(),
        32.vertical(),
        Text(
          "surveillance_system".tr(),
          style: kH524PxMedium.copyWith(color: kDarkPrimary),
        ),
        32.vertical(),
        Text(
          "enter_confirmation_code".tr(),
          style: kBody16PxRegular,
        ),
        12.vertical(),
        Text(
          "4_digits_code_sent_to_number".tr(
            namedArgs: {
              "number":
                  "+966${authProvider.previousSate == AuthViewEnum.login ? authProvider.loginPhoneController.text.trim() : authProvider.registerPhoneController.text.trim()}",
            },
          ),
          style: kSmall12PxRegular.copyWith(color: kDisabledColor),
          textAlign: TextAlign.center,
        ),
        12.vertical(),
        if (authProvider.resendOtpCountdown > 0)
          RichText(
              text: TextSpan(
                  text: "${"resend_otp_in".tr()} ",
                  style: kSmall12PxRegular.copyWith(color: Colors.black),
                  children: [
                TextSpan(
                    text: "${authProvider.resendOtpCountdown}s",
                    style: const TextStyle(color: kPrimaryColor))
              ]))
        else
          GestureDetector(
            onTap: authProvider.resendOtp,
            child: Text(
              "resend_otp".tr(),
              style: kSmall12PxRegular.copyWith(color: kPrimaryColor),
            ),
          ),
        32.vertical(),
        PinCodeTextField(
          enableActiveFill: false,
          mainAxisAlignment: MainAxisAlignment.center,
          cursorColor: kDarkPrimary,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              fieldWidth: 48,
              fieldHeight: 48,
              borderWidth: 1,
              borderRadius: BorderRadius.circular(12),
              activeColor: authProvider.otpError
                  ? kAlertError
                  : kDisabledColor.withOpacity(0.5),
              selectedColor:
                  authProvider.otpError ? kAlertError : kPrimaryColor,
              inactiveColor: authProvider.otpError
                  ? kAlertError
                  : kDisabledColor.withOpacity(0.5),
              fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
              errorBorderColor: kAlertError),
          appContext: context,
          length: 4,
          textStyle: kBody16PxRegular,
          validator: (value) {
            return value?.length != 4 ? "" : null;
          },
          onChanged: (value) {
            authProvider.otpError = false;
          },
          keyboardType: TextInputType.number,
          controller: authProvider.otpCodeController,
          onCompleted: (value) {
            authProvider.goToHome();
          },
        ),
        32.vertical(),
        Row(
          children: [
            Expanded(
              child: AppOutlinedButton(
                title: "back".tr(),
                onPressed: authProvider.back,
              ),
            ),
            16.horizontal(),
            Expanded(
              child: AppButton(
                enabled: authProvider.otpButtonEnabled,
                title:authProvider.previousSate == AuthViewEnum.register ? "next".tr() : "login".tr(),
                onPressed: authProvider.goToHome,
                isLoading: authProvider.isLoading,
              ),
            ),
          ],
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
