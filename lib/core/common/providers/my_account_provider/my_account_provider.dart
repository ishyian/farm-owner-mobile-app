import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/api/model/auth/my_account_response.dart';
import 'package:weqaa/core/auth/providers/auth_provider/auth_respository.dart';
import 'package:weqaa/core/auth/views/auth_view/auth_view.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class MyAccountProvider with ChangeNotifier{
  bool _isPopUpOpen = false;
  MyAccountResponse _userDetails = MyAccountResponse();
  final AuthRepository authRepository = locator<AuthRepository>();

  bool get isPopUpOpen => _isPopUpOpen;
  MyAccountResponse? get userDetails => _userDetails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void changeValue(bool val){
    _isPopUpOpen = val;
    notifyListeners();
  }

  Future<void> getAccountDetails() async {
    try {
      _userDetails = await authRepository.getAccountDetails();
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  void logout(BuildContext context) async{
    isLoading = true;
    await authRepository.logOut();
    isLoading = false;
    changeValue(false);
    locator<NavHelper>().pushAndRemoveUntilFirst(const AuthView());
    notifyListeners();
  }


}

