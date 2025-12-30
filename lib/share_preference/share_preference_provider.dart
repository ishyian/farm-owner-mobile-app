import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/share_pref_constants.dart';

class PreferenceService {

  SharedPreferences sharedPreferences;
  PreferenceService(this.sharedPreferences);

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getToken() {
    debugPrint(sharedPreferences.getString(keyToken));
    return sharedPreferences.getString(keyToken);
  }

  String? getUserType() {
    return sharedPreferences.getString(keyUserType);
  }

  Future<void> removeData() async{
    sharedPreferences.remove(keyToken);
    sharedPreferences.remove(keyUserType);
  }

  void logoutUser(){
    //TODO: redirect to specific login screen
  }

  Future<void> storeDefaultLang({required String language}) async {
    sharedPreferences.setString(keyDefaultLang,language);
  }

  Future<String?> retrieveDefaultLanguage() async {
    return  sharedPreferences.getString(keyDefaultLang);
  }

  Future<void> setToken(String token) async{
    sharedPreferences.setString(keyToken, token);
  }

  Future<void> setUserType(String userType) async{
    sharedPreferences.setString(keyUserType,userType);
  }

  Future<String?> retrieveUserType() async {
    return  sharedPreferences.getString(keyUserType);
  }

}