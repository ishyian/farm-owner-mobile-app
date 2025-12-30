import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weqaa/api/http_handler.dart';
import 'package:weqaa/share_preference/share_preference_provider.dart';
import 'package:weqaa/utils/helpers/locator.dart';

class BaseRepository {
  HTTPHandler httpHandler = HTTPHandler(locator.get<Dio>(), locator.get<PreferenceService>());
  String baseUrl = dotenv.env["BASE_URL"]!;
}
