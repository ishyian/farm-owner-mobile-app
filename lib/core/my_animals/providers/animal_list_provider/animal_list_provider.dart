import 'package:flutter/cupertino.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/utils/helpers/locator.dart';

class AnimalListProvider with ChangeNotifier {
  List<MyAnimalResponse> individualAnimalsList = [];
  List<MyAnimalResponse> batchAnimalsList = [];
  final HomeRepository homeRepository = locator<HomeRepository>();
  bool _visible = false;

  bool get visible => _visible;

  Future<void> fetchIndividualAnimalsList() async {
    if(individualAnimalsList.isEmpty){
      _visible = false;
    }
    individualAnimalsList = await homeRepository.getAnimals(false);
    _visible = true;
    notifyListeners();
  }

  Future<void> fetchBatchAnimalsList() async {
    if(batchAnimalsList.isEmpty){
      _visible = false;
    }
    batchAnimalsList = await homeRepository.getAnimals(true);
    _visible = true;
    notifyListeners();
  }

  bool isListEmpty(bool isIndividual) {
    return isIndividual ? individualAnimalsList.isEmpty : batchAnimalsList.isEmpty;
  }

  List<MyAnimalResponse> getCurrentList(bool isIndividual) {
    return isIndividual ? individualAnimalsList : batchAnimalsList;
  }

  void isVisible(bool val){
    _visible = val;
    notifyListeners();
  }
}
