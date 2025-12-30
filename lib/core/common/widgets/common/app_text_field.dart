import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.hint,
      this.title,
      this.obsecureText = false,
      this.suffix,
      this.textInputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      required this.controller,
      this.validator,
      this.borderRadius = 12,
      this.onChanged,
      this.contentPadding =
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      this.onSubmitted,
      this.prefix,
      this.errorTextStyle,
      this.inputFormatters,
      this.label,
      this.autoCorrect = true,
      this.showLabel = true,
      this.readOnly,
      this.maxLines = 1,
      this.fillColor,
      this.borderColor,
      this.minLines,
      this.isBigTitle = false,
      this.titleStyle,
      this.onTap,
      this.focusNode});
  final String? hint;
  final bool obsecureText;
  final Widget? suffix;
  final Widget? prefix;
  final String? label;
  final bool isBigTitle;
  final int maxLines;
  final Color? fillColor;
  final Color? borderColor;
  final int? minLines;
  final bool showLabel;
  final TextStyle? errorTextStyle;
  final double borderRadius;
  final TextInputType textInputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final Function(String? value)? onChanged;
  final Function(String? value)? onSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final VoidCallback? onTap;
  final EdgeInsets contentPadding;
  final bool autoCorrect;
  final String? title;
  final TextStyle? titleStyle;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title!,
                style: kSmall12PxRegular,
              ),
            ),
          ),
        TextFormField(
          autocorrect: autoCorrect,
          onTap: onTap,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatters,
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          obscureText: obsecureText,
          style: kBody16PxRegular,
          textInputAction: inputAction,
          validator: validator,
          maxLines: maxLines,
          minLines: minLines,
          focusNode: focusNode,
          keyboardType: textInputType,
          decoration: InputDecoration(
            errorMaxLines: 2,
            prefixIconColor: kHintColor,
            suffixIconColor: kHintColor,
            suffixIcon: suffix,
            prefixIcon: prefix,
            contentPadding: contentPadding,
            fillColor: fillColor,
            filled: fillColor != null,
            hintText: hint ?? label,
            hintStyle: kBody16PxRegular.copyWith(color: kHintColor),
            errorStyle: errorTextStyle,
            border: border(),
            enabledBorder: border(),
            errorBorder: border(color: kAlertError),
            focusedBorder: border(focused: true),
          ),
        ),
      ],
    );
  }

  InputBorder border({bool focused = false, Color? color}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: color ?? kStrokeColor,
        ),
      );
}
