import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weqaa/api/model/auth/register_response.dart';
import 'package:weqaa/core/auth/views/auth_view/auth_view.dart';
import 'package:weqaa/core/common/views/start_view/start_view.dart';
import 'package:weqaa/utils/helpers/location_helper.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';
import 'package:weqaa/core/auth/providers/auth_provider/auth_respository.dart';
import 'package:weqaa/utils/helpers/ui_helper.dart';

class CompleteProfileProvider extends ChangeNotifier {
  final locationHelper = LocationHelper();
  final formKey = GlobalKey<FormState>();
  final facilities = ["1", "2", "3"];
  final facilityIdController = TextEditingController();
  final farmNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final nationalIdController = TextEditingController();
  final locationManuallyController = TextEditingController();

  final locationLatitudeLabelController = TextEditingController();
  final AuthRepository authRepository = locator<AuthRepository>();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _isApiLoading = false;
  bool get isApiLoading => _isApiLoading;
  set isApiLoading(bool value) {
    _isApiLoading = value;
    notifyListeners();
  }

  String? _facilityId;
  String? get facilityId => _facilityId;

  set facilityId(String? value) {
    _facilityId = value;
    notifyListeners();
  }

  bool _haveFacilityId = true;

  bool get haveFacilityId => _haveFacilityId;
  set haveFacilityId(bool value) {
    _haveFacilityId = value;
    notifyListeners();
  }

  get isFormValid => formKey.currentState?.validate() ?? false;

  Future getLocation() async {
    try {
      loading = true;
      final res = await locationHelper.determinePosition();
      if (res is LocationData) {
        locationLatitudeLabelController.text =
            "${res.latitude}, ${res.longitude}";
      }
    } catch (e) {
      return null;
    }
    loading = false;
  }

  void reNotifyWidgets() {
    formKey.currentState?.validate();
    notifyListeners();
  }

  Future submit(String mobile,String userTypeId) async {
    if (formKey.currentState?.validate() ?? false) {
      if(_haveFacilityId){
        isApiLoading = true;
        await registerUser(mobile, userTypeId);
        isApiLoading = false;
        locator<NavHelper>().pushAndRemoveUntilFirst(const AuthView());
        locator<UiHelper>().showSnackBar("Successfully registered.", isError: false);
      }else{
        locator<UiHelper>().showSnackBar("Currently no API available.", isError: true);
      }
    }
  }

  Future<void> registerUser(String mobile,String userTypeId) async{
    final RegisterResponse response = await authRepository.registerUser(
      facilityId: facilityId.toString(),
      facilityName: farmNameController.text,
      location: locationLatitudeLabelController.text,
      manualLocation: locationManuallyController.text,
      mobile:mobile,
      nationalID: nationalIdController.text,
      ownerName: ownerNameController.text,
      userTypeId: userTypeId
    );
    debugPrint(response.message);
    notifyListeners();
  }
}
