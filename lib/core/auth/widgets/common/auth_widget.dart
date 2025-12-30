import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/core/auth/providers/auth_provider/auth_provider.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/utils/extensions/num.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key, required this.child});
  final Widget child;
  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.fetchUserTypes();
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        gradient: kAppGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: SizedBox(
          height: screenHeight,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    R.assetsImagesCommonWeqaaLogo,
                    width: 130,
                    height: 115,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                decoration: const BoxDecoration(
                  color: kScaffoldColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: widget.child,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
