import 'package:flutter/material.dart';

import '../../constants/dimen_constants.dart';
import 'locator.dart';
import 'nav_helper.dart';

class UiHelper {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(String title, {isError = false}) {
    ScaffoldMessenger.of(locator<NavHelper>().getContext()).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: dimen20,
              width: dimen2,
              color: isError ? Colors.red : Colors.green,
            ),
            const SizedBox(width: dimen10),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: dimen8, vertical: dimen12),
      ),
    );
  }
}
