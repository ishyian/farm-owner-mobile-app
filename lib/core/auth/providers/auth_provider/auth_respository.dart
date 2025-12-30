import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weqaa/api/model/auth/log_out_response.dart';
import 'package:weqaa/api/model/auth/login_response.dart';
import 'package:weqaa/api/model/auth/my_account_response.dart';
import 'package:weqaa/api/model/auth/register_response.dart';
import 'package:weqaa/api/model/auth/send_otp_response.dart';
import 'package:weqaa/api/model/auth/user_type_response.dart';
import 'package:weqaa/api/model/auth/verify_otp_response.dart';
import 'package:weqaa/constants/api_constants.dart';
import 'package:weqaa/core/common/repositories/BaseRepository.dart';
import 'package:weqaa/share_preference/share_preference_provider.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/ui_helper.dart';

class AuthRepository extends BaseRepository {
  final PreferenceService _preferenceService = locator<PreferenceService>();

  Future<SendOTPResponse?> sendOTP(
      {String mobileNumber = "", String? userType = ""}) async {
    // send otp
    try {
      Response<dynamic> response = await httpHandler.post(
          url:
              '$baseUrl${ApiConstant.sendOtp}?${ApiConstant.mobile}=$mobileNumber',
          data: {},
          isTokenRequired: false);

      await _preferenceService.setUserType(userType!);

      return SendOTPResponse.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      locator<UiHelper>().showSnackBar("Unable to send otp.", isError: true);
      throw Exception("Error is sending otp");
    }
  }

  Future<List<UserTypeResponse>> fetchUserTypes() async {
    try {
      Response response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.userTypes}',
        isTokenRequired: false
      );

      // List<dynamic> data = jsonDecode(response.toString());
      return UserTypeResponse.fromJsonList(response.data);
    } catch (e) {
      locator<UiHelper>().showSnackBar("Error in getting user types.", isError: true);
      throw Exception('Error fetching user types');
    }
  }

  Future<LoginResponse?> login(
      {String mobileNumber = "", String otp = ""}) async {
    try {
      Response<dynamic> response = await httpHandler.post(
          url: '$baseUrl${ApiConstant.login}',
          data: {ApiConstant.mobile: mobileNumber, ApiConstant.otp: otp},
        isTokenRequired: false
      );

      LoginResponse loginResponse =
          LoginResponse.fromJson(jsonDecode(response.toString()));
      await locator<PreferenceService>().setToken(loginResponse.accessToken!);
      return loginResponse;
    } catch (e) {
      locator<UiHelper>().showSnackBar("Unable to login.", isError: true);
      throw Exception('Error in login');
    }
  }

  Future<VerifyOtpResponse> verifyOtp(
      {String mobileNumber = "", String otp = ""}) async {
    try {
      Response<dynamic> response = await httpHandler.post(
          url:
              '$baseUrl${ApiConstant.verifyOtp}?${ApiConstant.mobile}=$mobileNumber&${ApiConstant.otp}=$otp',
          data: {},
          isTokenRequired: false);

      return VerifyOtpResponse.fromJson(jsonDecode(response.toString()));
    } catch (e) {
      locator<UiHelper>().showSnackBar("Unable to verify otp.", isError: true);
      throw Exception("Error in verifying otp.");
    }
  }

  Future<String?> getUserType() async {
    return _preferenceService.retrieveUserType();
  }

  Future<RegisterResponse> registerUser(
      {String facilityId = "",
      String facilityName = "",
      String ownerName = "",
      String nationalID = "",
      String location = "",
      String manualLocation = "",
      String userTypeId = "",
      String mobile = ""}) async {
    try{
      Response<dynamic> response =
      await httpHandler.post(url: '$baseUrl${ApiConstant.register}',
        data: {
        ApiConstant.facilityId: facilityId,
        ApiConstant.facilityName: facilityName,
        ApiConstant.ownerName: ownerName,
        ApiConstant.nationalID: nationalID,
        ApiConstant.manualLocation: manualLocation,
        ApiConstant.location: location,
        ApiConstant.userTypeId: userTypeId,
        ApiConstant.mobile: mobile
      },
          isTokenRequired:false
      );
      return RegisterResponse.fromJson(jsonDecode(response.toString()));
    }catch(e){
      locator<UiHelper>().showSnackBar("Unable to register user.", isError: true);
     throw Exception("Error in register user");
    }
  }

  Future<MyAccountResponse> getAccountDetails() async{
    try{
      Response<dynamic> response = await httpHandler.post(url: '$baseUrl${ApiConstant.getAccountDetails}', data: {} , isTokenRequired: true);
      return MyAccountResponse.fromJson(jsonDecode(response.toString()));
    }catch(e){
      locator<UiHelper>().showSnackBar("Unable to get account details.", isError: true);
      throw Exception("Error in getting account details $e");
    }
  }

  Future<LogOutResponse> logOut() async{
    try{
      Response<dynamic> response = await httpHandler.post(url: '$baseUrl${ApiConstant.logOut}', data: {} , isTokenRequired: true);
      await locator<PreferenceService>().removeData();
      return LogOutResponse.fromJson(jsonDecode(response.toString()));
    }catch(e){
      locator<UiHelper>().showSnackBar("Unable to logout.", isError: true);
      throw Exception("Error in performing logout $e");
    }
  }

}
