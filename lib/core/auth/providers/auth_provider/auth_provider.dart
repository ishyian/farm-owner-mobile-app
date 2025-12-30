import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weqaa/api/model/auth/login_response.dart';
import 'package:weqaa/api/model/auth/my_account_response.dart';
import 'package:weqaa/api/model/auth/send_otp_response.dart';
import 'package:weqaa/api/model/auth/user_type_response.dart';
import 'package:weqaa/api/model/auth/verify_otp_response.dart';
import 'package:weqaa/core/auth/enums/auth_view_enums.dart';
import 'package:weqaa/core/auth/views/complete_profile_view/complete_profile_view.dart';
import 'package:weqaa/core/common/views/start_view/start_view.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';
import 'package:weqaa/core/auth/providers/auth_provider/auth_respository.dart';
import 'package:weqaa/utils/helpers/ui_helper.dart';

class AuthProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final loginPhoneController = TextEditingController();
  final registerPhoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();
  List<String> userTypes = [];
  List<UserTypeResponse> userTypesList = [];
  late MyAccountResponse userDetails;
  final AuthRepository authRepository = locator<AuthRepository>();
  bool _isLoading = false;

  String? _loginUserType;
  String? _registerUserType;
  AuthViewEnum _authViewEnum = AuthViewEnum.login;
  AuthViewEnum? previousSate;
  bool _otpError = false;

  bool get otpError => _otpError;

  set otpError(bool value) {
    _otpError = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int _resendOtpCountdown = 60;
  Timer? _resendOtpTimer;

  int get resendOtpCountdown => _resendOtpCountdown;

  String? get loginUserType => _loginUserType;

  set loginUserType(String? value) {
    _loginUserType = value;
    notifyListeners();
  }

  String? get registerUserType => _registerUserType;

  set registerUserType(String? value) {
    _registerUserType = value;
    notifyListeners();
  }

  AuthViewEnum get authViewEnum => _authViewEnum;

  set authViewEnum(AuthViewEnum value) {
    _authViewEnum = value;
    notifyListeners();
  }

  get loginButtonEnabled => loginPhoneController.text.length >= 9 && loginUserType != null;

  get otpButtonEnabled => true;

  get registerButtonEnabled => registerPhoneController.text.length >= 9 && registerUserType != null;

  @override
  void dispose() {
    loginPhoneController.dispose();
    registerPhoneController.dispose();
    otpCodeController.dispose();
    _resendOtpTimer?.cancel();

    super.dispose();
  }

  void reNotifyWidget() {
    notifyListeners();
  }

  void navigateToRegister() {
    _registerUserType = null;
    registerPhoneController.text = "";
    _authViewEnum = AuthViewEnum.register;
    notifyListeners();
  }

  void navigateToLogin() {
    _authViewEnum = AuthViewEnum.login;
    notifyListeners();
  }

  void naviageToOtp() {
    otpError = false;
    otpCodeController = TextEditingController();
    previousSate = _authViewEnum;
    _authViewEnum = AuthViewEnum.otp;
    startResendOtpCountdown();
    notifyListeners();
  }

  Future sendLoginOTP() async {
    if (loginUserType == "Farm Owner" || loginUserType == "Slaughterhouse Owner") {
      isLoading = true;
      final SendOTPResponse? response =
          await authRepository.sendOTP(mobileNumber: loginPhoneController.text, userType: loginUserType);
      isLoading = false;
      if (response?.data != null) {
        naviageToOtp();
      }
    } else {
      locator<UiHelper>()
          .showSnackBar("You are not allowed to login. Please contact admin for more information.", isError: true);
    }
    notifyListeners();
  }

  Future sendRegisterOTP() async {
    if (registerUserType == "Farm Owner" || registerUserType == "Slaughterhouse Owner") {
      isLoading = true;
      final SendOTPResponse? response =
          await authRepository.sendOTP(mobileNumber: registerPhoneController.text, userType: registerUserType);
      isLoading = false;
      if (response?.data != null) {
        naviageToOtp();
      }
    } else {
      locator<UiHelper>()
          .showSnackBar("You are not allowed to register. Please contact admin for more information.", isError: true);
    }
    notifyListeners();
  }

  Future register() async {
    isLoading = true;
    final VerifyOtpResponse response = await authRepository.verifyOtp(
      otp: otpCodeController.text,
      mobileNumber: registerPhoneController.text,
    );
    isLoading = false;
    debugPrint(response.message);
    notifyListeners();
  }

  Future login() async {
    isLoading = true;
    final LoginResponse? response =
        await authRepository.login(mobileNumber: loginPhoneController.text, otp: otpCodeController.text);
    isLoading = false;
  }

  Future goToHome() async {
    if (formKey.currentState?.validate() ?? false) {
      if (previousSate == AuthViewEnum.register) {
        await register();
        locator<NavHelper>().pushReplacement(CompleteProfileView(
          mobile: registerPhoneController.text,
          usertypeId: getIdByUserTitle(registerUserType!),
        ));
      } else {
        await login();
        locator<NavHelper>().pushReplacement(StartView(userType: await authRepository.getUserType()));
      }
    } else {
      otpError = true;
    }
  }

  void back() {
    _authViewEnum = previousSate!;
    notifyListeners();
  }

  void startResendOtpCountdown() {
    _resendOtpCountdown = 60;
    notifyListeners();
    _resendOtpTimer?.cancel();
    _resendOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendOtpCountdown > 0) {
        _resendOtpCountdown--;
        notifyListeners();
      } else {
        _resendOtpTimer?.cancel();
      }
    });
  }

  void resendOtp() {
    if (previousSate == AuthViewEnum.register) {
      sendRegisterOTP();
    } else {
      sendLoginOTP();
    }
    startResendOtpCountdown();
    notifyListeners();
  }

  Future<void> fetchUserTypes() async {
    userTypesList = await authRepository.fetchUserTypes();
    userTypes = userTypesList.map((userType) => formatTitle(userType.title ?? "")).toList();
    notifyListeners();
  }

  String formatTitle(String title) {
    return title.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }

  String getIdByUserTitle(String title) {
    final userType = userTypesList.firstWhere(
      (userType) => userType.title == title,
    );
    return userType.id!;
  }

  Future<void> getUserDetails() async {
    userDetails = await authRepository.getAccountDetails();
    notifyListeners();
  }
}
