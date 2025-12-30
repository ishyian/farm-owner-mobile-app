import 'package:flutter/cupertino.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/utils/helpers/locator.dart';

class RegisteredAnimalDetailsProvider with ChangeNotifier {
  MyAnimalResponse? animal;
  final HomeRepository homeRepository = locator<HomeRepository>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchAnimalDetails(String id) async {
    isLoading = true;
    animal = await homeRepository.getAnimalById(id);
    isLoading = false;
  }
}
