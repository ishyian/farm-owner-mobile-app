import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/core/common/views/splash_view/splash_view.dart';
import 'package:weqaa/core/common/views/start_view/start_view.dart';
import 'package:weqaa/utils/extensions/context.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';
import 'package:weqaa/utils/helpers/ui_helper.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget customBuilder(BuildContext context, Widget? child) {
    Widget modifiedChild = MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: child!,
    );

    return DevicePreview.appBuilder(context, modifiedChild);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: locator<UiHelper>().scaffoldMessengerKey,
      navigatorKey: locator<NavHelper>().navigatorKey,

      navigatorObservers: [
        locator<NavHelper>().routeObserver,
      ],
      title: "Animal Welfare",
      theme: ThemeData(
        fontFamily: context.isArabic() ? "SSTArabic" : "Montserrat",
        scaffoldBackgroundColor: kScaffoldColor,
        colorScheme:
            const ColorScheme.light(primary: kPrimaryColor, error: kErrorColor),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),

      // builder: customBuilder,
      builder: (_, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      home: const SplashView(),
    );
  }
}
