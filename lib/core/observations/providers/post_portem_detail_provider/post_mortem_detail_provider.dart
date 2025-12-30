import 'package:flutter/cupertino.dart';
import 'package:weqaa/api/model/home/observations_response.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/utils/helpers/locator.dart';

class PostMortemDetailProvider with ChangeNotifier {
  PostMortem? postMortem;
  final HomeRepository homeRepository = locator<HomeRepository>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchPostMortem(String id) async {
    isLoading = true;
    postMortem = await homeRepository.getPostMortemById(id);
    isLoading = false;
  }
}
