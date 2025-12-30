import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/ui_helper.dart';

import '../share_preference/share_preference_provider.dart';

class HTTPHandler {
  Dio dio;
  PreferenceService preferenceService;

  HTTPHandler(this.dio, this.preferenceService);

  //! GET REQUEST
  Future get({required String url, isTokenRequired = true}) async {
    try {
      debugPrint("Token is ${preferenceService.getToken()}");
      Response res = await dio.get(url,
          options: isTokenRequired
              ? Options(
                  headers: {
                    'Authorization': 'Bearer ${preferenceService.getToken()}'
                  },
                )
              : null);

      if (res.statusCode == 400) {
        var message = res.data['message'];
        locator.get<UiHelper>().showSnackBar(
            (message is String) ? message : 'Something went wrong',
            isError: true);
      }

      if (res.statusCode == 403) {
        preferenceService.logoutUser();
      }

      if (res.statusCode == 200 || res.statusCode == 201) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Exception for ($url) = $e");
      return null;
    }
  }

  //! POST REQUEST
  Future post({
    required String url,
    required Map<String, dynamic> data,
    isTokenRequired = true,
    FormData? formData,
  }) async {
    try {
      Response res;
      if (formData != null) {
        res = await dio.post(
          url,
          data: formData,
          options: isTokenRequired
              ? Options(
                  headers: {
                    'Authorization': 'Bearer ${preferenceService.getToken()}',
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                  },
                )
              : null,
        );
      } else {
        res = await dio.post(
          url,
          data: data,
          options: isTokenRequired
              ? Options(
                  headers: {
                    'Authorization': 'Bearer ${preferenceService.getToken()}',
                  },
                )
              : null,
        );
      }

      debugPrint("token is ${preferenceService.getToken()}");
      debugPrint("Response for ($url) = $res");

      if (res.statusCode == 400) {
        var message = res.data['message'];
        locator.get<UiHelper>().showSnackBar(
            (message is String) ? message : 'Something went wrong',
            isError: true);
      }

      if (res.statusCode == 401) {
        // preferenceService.logoutUser();
        // nevigate to login
        debugPrint("Error in login");
      }
      if (res.statusCode == 403) {
        preferenceService.logoutUser();
        // nevigate to login
      }
      if (res.statusCode == 200 || res.statusCode == 201) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Exception for ($url) = $e");
      if ((e as dynamic).type == DioExceptionType.receiveTimeout) {
        locator
            .get<UiHelper>()
            .showSnackBar('receiving timeout!', isError: true);
      }
      return null;
    }
  }

  //! UPDATE REQUEST
  Future put({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response res = await dio.put(
        url,
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer ${preferenceService.getToken()}'},
        ),
      );
      if (res.statusCode == 400) {
        var message = res.data['message'];
        locator.get<UiHelper>().showSnackBar(
            (message is String) ? message : 'Something went wrong',
            isError: true);
      }
      if (res.statusCode == 403) {
        preferenceService.logoutUser();
      }

      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 422) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //! DELETE REQUEST
  Future delete({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    debugPrint("user token for delete user :${preferenceService.getToken()}");
    try {
      final res = await dio.delete(
        url,
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer ${preferenceService.getToken()}'},
        ),
      );
      if (res.statusCode == 400) {
        var message = res.data['message'];
        locator.get<UiHelper>().showSnackBar(
            (message is String) ? message : 'Something went wrong',
            isError: true);
      }
      if (res.statusCode == 403) {
        preferenceService.logoutUser();
      }

      if (res.statusCode == 200 ||
          res.statusCode == 201 ||
          res.statusCode == 422) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //! Post Form Data
  Future postFormData({
    required String url,
    required FormData data,
  }) async {
    try {
      final res = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer ${preferenceService.getToken()}'},
        ),
      );

      debugPrint("Response for ($url) = $res");

      if (res.statusCode == 400) {
        var message = res.data['message'];
        locator.get<UiHelper>().showSnackBar(
            (message is String) ? message : 'Something went wrong',
            isError: true);
      }
      if (res.statusCode == 403) {
        preferenceService.logoutUser();
      }

      if (res.statusCode == 200 || res.statusCode == 201) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
