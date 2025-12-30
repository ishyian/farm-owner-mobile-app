import 'package:flutter/cupertino.dart';
import 'package:weqaa/api/model/home/observations_response.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/utils/helpers/locator.dart';

class ObservationListProvider with ChangeNotifier {
  List<AnimalScreening> animalScreenings = [];
  List<PostMortem> postMortems = [];
  final HomeRepository homeRepository = locator<HomeRepository>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchAnimalScreeningList() async {
    isLoading = true;
    animalScreenings = await homeRepository.getAnimalScreenings();
    postMortems = await homeRepository.getPostMortems();
    isLoading = false;
  }
}
