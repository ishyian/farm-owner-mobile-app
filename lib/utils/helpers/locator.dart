import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weqaa/core/auth/providers/auth_provider/auth_respository.dart';
import 'package:weqaa/core/common/repositories/BaseRepository.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/share_preference/share_preference_provider.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';
import 'package:weqaa/utils/helpers/ui_helper.dart';

final locator = GetIt.instance;

Future setupLocator() async {
  locator.registerSingleton(NavHelper());

  locator.registerSingleton(UiHelper());

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(PreferenceService(sharedPreferences));

  locator.registerSingleton(
      Dio(
          BaseOptions(
              baseUrl: dotenv.env["BASE_URL"]!
          )
      )
  );

  locator.registerSingleton(BaseRepository());

  locator.registerSingleton(AuthRepository());

  locator.registerSingleton(HomeRepository());
}
