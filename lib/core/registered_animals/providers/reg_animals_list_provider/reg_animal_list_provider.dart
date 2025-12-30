import 'package:flutter/cupertino.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/utils/helpers/locator.dart';

class RegisteredAnimalListProvider with ChangeNotifier {
  List<MyAnimalResponse> registeredAnimalsList = [];
  final HomeRepository homeRepository = locator<HomeRepository>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchAnimals() async {
    isLoading = true;
    registeredAnimalsList = await homeRepository.getAnimals(false);
    isLoading = false;
  }
}
