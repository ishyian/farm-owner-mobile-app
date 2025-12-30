import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weqaa/app.dart';
import 'package:weqaa/core/common/providers/my_account_provider/my_account_provider.dart';
import 'package:weqaa/core/my_animals/providers/animal_list_provider/animal_list_provider.dart';
import 'package:weqaa/core/observations/providers/initial_screening_detail_provider/initial_screening_detail_provider.dart';
import 'package:weqaa/core/observations/providers/initial_screening_list_provider/initial_screening_list_provider.dart';
import 'package:weqaa/core/observations/providers/observation_form_provider/initial_screening_form_provider.dart';
import 'package:weqaa/core/observations/providers/post_portem_detail_provider/post_mortem_detail_provider.dart';
import 'package:weqaa/core/registered_animals/providers/reg_animal_details_provider/reg_animal_details_provider.dart';
import 'package:weqaa/core/registered_animals/providers/reg_animal_form_provider/reg_animal_form_provider.dart';
import 'package:weqaa/core/registered_animals/providers/reg_animals_list_provider/reg_animal_list_provider.dart';
import 'package:weqaa/utils/helpers/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  await EasyLocalization.ensureInitialized();

  await Future.wait([
    setupLocator(),
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => RegisteredAnimalFormProvider()),
      ChangeNotifierProvider(create: (context) => MyAccountProvider()),
      ChangeNotifierProvider(create: (context) => AnimalListProvider()),
      ChangeNotifierProvider(create: (context) => ObservationListProvider()),
      ChangeNotifierProvider(
          create: (context) => InitialScreeningDetailProvider()),
      ChangeNotifierProvider(create: (context) => PostMortemDetailProvider()),
      ChangeNotifierProvider(
          create: (context) => RegisteredAnimalListProvider()),
      ChangeNotifierProvider(
          create: (context) => RegisteredAnimalDetailsProvider()),
      ChangeNotifierProvider(
          create: (context) => InitialScreeningFormProvider())
    ],
    child: EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: "assets/translations",
      fallbackLocale: const Locale("en"),
      child: const MyApp(),
    ),
  ));
}
