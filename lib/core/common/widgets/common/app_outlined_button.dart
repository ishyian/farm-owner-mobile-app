import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.icon,
    this.textColor,
  });

  final VoidCallback onPressed;
  final String title;
  final Widget? icon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 2, color: kDarkPrimary),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Stack(
          children: <Widget>[
            if (icon != null)
              Align(alignment: Alignment.centerLeft, child: icon!),
            Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor ?? kDarkPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
