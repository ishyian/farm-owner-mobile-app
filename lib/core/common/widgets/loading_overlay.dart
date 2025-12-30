import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.child,
    required this.loading,
    this.backGroundColor,
    this.progress,
    this.progressColor,
  });

  final Widget child;
  final bool loading;
  final Color? backGroundColor;
  final double? progress;
  final Color? progressColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          Container(
            width: double.infinity,
            color: backGroundColor ?? Colors.black.withOpacity(.5),
            child: Center(
                child: CircularProgressIndicator(
                    color: progressColor ?? Colors.white)),
          )
      ],
    );
  }
}
