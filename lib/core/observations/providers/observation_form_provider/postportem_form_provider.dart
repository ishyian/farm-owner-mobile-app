import 'package:flutter/material.dart';
import 'package:weqaa/api/model/home/add_postmortem_request.dart';
import 'package:weqaa/api/model/home/observations_response.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/core/observations/model/examined_organs.dart';
import 'package:weqaa/core/observations/model/observations.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

import '../../model/animal_postportem_model.dart';

class PostportemFormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final postportemDateController = TextEditingController();
  final animalOrgansCollectedController = TextEditingController();
  final HomeRepository homeRepository = locator<HomeRepository>();

  final remarksController = TextEditingController();
  final List<String> examinedOrgansList =
      ExaminedOrgansExtension.allExaminedOrgans;
  final List<String> observationsList = ObservationsExtension.allObservations;
  final List<String> carcassCondemnationList = ['NA', 'Partial', 'Full'];
  List<AnimalPostportemModel> postmortemModels = [AnimalPostportemModel()];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  PostportemFormProvider() {
    animalOrgansCollectedController.text = "1".toString();
  }

  Future submit() async {
    if (formKey.currentState?.validate() ?? false) {
      AddPostMortemRequest request = AddPostMortemRequest(
          dateOfPostMortem: postportemDateController.text,
          noOfAnimalsScreened: 15,
          noOfAnimalsOrgansCollected: postmortemModels.length,
          details: postmortemModels
              .map((model) => Details(
                    animalId: model.animalBatchId,
                    examinedOrgan: model.examinedOrgan,
                    observation: model.observation,
                    carcassCondemnation: model.carcassCondemnation,
                  ))
              .toList());
      addPostMortem(request);
    }
  }

  Future<void> addPostMortem(AddPostMortemRequest requestModel) async {
    isLoading = true;
    PostMortem postMortem = await homeRepository.addPostMortem(requestModel);
    isLoading = false;
    //resetValues();
    locator<NavHelper>().pop();
  }

  void addAnimalPostmortem() {
    final postportemModel = AnimalPostportemModel();
    postmortemModels.add(postportemModel);
    animalOrgansCollectedController.text = postmortemModels.length.toString();
    notifyListeners();
  }

  void removeVaccination(int index) {
    postmortemModels.removeAt(index);
    animalOrgansCollectedController.text = postmortemModels.length.toString();
    notifyListeners();
  }
}
