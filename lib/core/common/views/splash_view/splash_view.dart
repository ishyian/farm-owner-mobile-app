import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/core/auth/views/auth_view/auth_view.dart';
import 'package:weqaa/core/common/views/start_view/start_view.dart';
import 'package:weqaa/r.dart';
import 'package:weqaa/share_preference/share_preference_provider.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    String? token = locator<PreferenceService>().getToken();
    String? userType = locator<PreferenceService>().getUserType();

    if (token != null) {
      Future.delayed(const Duration(seconds: 3), () {
        locator<NavHelper>().pushReplacement(StartView(
          userType: userType,
        ));
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        locator<NavHelper>().pushReplacement(const AuthView());
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: kAppGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            R.assetsImagesCommonWeqaaLogo,
                            width: 165,
                            height: 150,
                          ),
                          Image.asset(
                            R.assetsImagesCommonWeqaaTitle,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Image.asset(
                  R.assetsImagesCommonArabicVector,
                  fit: BoxFit.fill,
                ))
          ],
        ),
      ),
    );
  }
}
