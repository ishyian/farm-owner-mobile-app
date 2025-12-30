import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.textColor,
      this.height,
      this.color,
      this.enabled = true,
      this.style,
      this.padding,
      this.child,
      this.isLoading = false});
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final TextStyle? style;
  final Color? color;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final Widget? child;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 40,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: enabled ? onPressed : null,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        fillColor: !enabled ? kDisabledColorLight : color ?? kDarkPrimary,
        child: isLoading
            ? SizedBox(height : 22 , width: 22 , child: CircularProgressIndicator(color: Colors.white,))
            : child ??
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: style ??
                      TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
      ),
    );
  }
}
