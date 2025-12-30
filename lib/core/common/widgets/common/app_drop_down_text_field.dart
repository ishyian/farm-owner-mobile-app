import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';

class AppDropDownTextField<T> extends StatelessWidget {
  const AppDropDownTextField({
    super.key,
    required this.items,
    this.onChanged,
    this.value,
    this.validator,
    this.hint,
    this.prefix,
    this.suffix,
    this.title,
    this.borderRadius = 12,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.errorTextStyle,
    this.fillColor,
    this.borderColor,
    this.isBigTitle = false,
    this.titleStyle,
    this.onTap,
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final FormFieldValidator<T>? validator;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final String? title;
  final double borderRadius;

  final EdgeInsets contentPadding;
  final TextStyle? errorTextStyle;
  final Color? fillColor;
  final Color? borderColor;
  final bool isBigTitle;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<T>(
            dropdownColor: kScaffoldColor,
            isExpanded: true,
            items: items,
            value: value,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            style: kBody16PxRegular,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: kHintColor,
              size: 16,
            ),
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: prefix,
              suffixIcon: suffix,
              contentPadding: contentPadding,
              fillColor: fillColor,
              filled: fillColor != null,
              hintText: hint,
              hintStyle: kBody16PxRegular.copyWith(color: kHintColor),
              // labelText: hint ,
              // labelStyle: kBody16PxRegular.copyWith(color: kHintColor),
              // floatingLabelBehavior: FloatingLabelBehavior.never,
              errorStyle: errorTextStyle,
              border: border(),
              enabledBorder: border(),
              errorBorder: border(color: kAlertError),
              focusedBorder: border(focused: true),
            ),
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
