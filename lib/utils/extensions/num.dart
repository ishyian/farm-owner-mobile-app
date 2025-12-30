import 'package:flutter/material.dart';

extension NumExtension on num {
  Widget vertical() => SizedBox(height: toDouble());
  Widget horizontal() => SizedBox(width: toDouble());
}
