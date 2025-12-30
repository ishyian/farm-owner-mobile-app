import 'package:flutter/cupertino.dart';
import 'package:weqaa/api/model/home/observations_response.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/utils/helpers/locator.dart';

class InitialScreeningDetailProvider with ChangeNotifier {
  AnimalScreening? animalScreening;
  final HomeRepository homeRepository = locator<HomeRepository>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchAnimalScreening(String id) async {
    isLoading = true;
    animalScreening = await homeRepository.getAnimalScreeningById(id);
    isLoading = false;
  }
}
