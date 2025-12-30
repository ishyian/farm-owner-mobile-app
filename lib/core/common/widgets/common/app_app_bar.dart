import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class AppAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AppAppBar(
      {super.key,
      required this.title,
      this.leading,
      this.actions,
      this.showBackIcon = true});
  final String title;
  final Widget? leading;
  final bool showBackIcon;
  final List<Widget>? actions;
  @override
  State<AppAppBar> createState() => _AppAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppAppBarState extends State<AppAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: widget.leading ??
          (widget.showBackIcon
              ? IconButton(
                  onPressed: () {
                    locator<NavHelper>().pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: kDarkPrimary,
                  ))
              : const SizedBox()),
      title: Text(
        widget.title,
        style: kBody16PxMedium.copyWith(color: Colors.black),
      ),
      actions: widget.actions,
    );
  }
}
