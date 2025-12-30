import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/api/model/home/add_animal_request.dart';
import 'package:weqaa/api/model/home/facility_response.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class RegisteredAnimalFormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final HomeRepository homeRepository = locator<HomeRepository>();

  final breedController = TextEditingController();
  final ageController = TextEditingController();
  final facilityIdController = TextEditingController();
  final ageGroupController = TextEditingController();
  List<String> sexList = ['male'.tr(), 'female'.tr()];
  List<Species> speciesList = [];
  List<Breed> breedList = [];
  List<Facility> facilities = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  RegisteredAnimalFormProvider();

  String? _sex;
  String? _species;
  String? _breed;

  void setSex(String? sex) {
    _sex = sex;
    notifyListeners();
  }

  String? get sex => _sex;

  String? get species => _species;

  set species(String? species) {
    _species = species;
    notifyListeners();
  }

  String? get breed => _breed;

  set breed(String? breed) {
    _breed = breed;
    notifyListeners();
  }

  Future scanAndGenerateTag() async {
    if (formKey.currentState?.validate() ?? false) {
      String? facilityId = facilities
          .firstWhereOrNull((f) => f.id.toString() == facilityIdController.text)
          ?.id;
      AddAnimalRequest request = AddAnimalRequest(
          facilityId: facilityId,
          sex: _sex,
          age: int.parse(ageController.text),
          speciesId: _species,
          breedId: _breed);
      addAnimal(request);
    }
  }

  Future<void> fetchCommonData() async {
    isLoading = true;
    speciesList = await homeRepository.getSpecies();
    breedList = await homeRepository.getBreeds();
    facilities = await homeRepository.getFacilities();
    isLoading = false;
  }

  Future<void> addAnimal(AddAnimalRequest request) async {
    try {
      isLoading = true;
      await homeRepository.addAnimalRequest(request);
      isLoading = false;
      locator<NavHelper>().pop();
    } catch (e) {
      isLoading = false;
      debugPrint(e.toString());
    }
  }

  Iterable<String> getFacilitySuggestions(String query) {
    return facilities
        .map((facility) => facility.id.toString())
        .where((String option) => option.contains(query));
  }

  @override
  void dispose() {
    breedController.dispose();
    ageController.dispose();
    ageGroupController.dispose();
    super.dispose();
  }

  void resetValues() {
    breedController.clear();
    ageController.clear();
    ageGroupController.clear();
    _sex = null;
    _species = null;
    _breed = null;
    notifyListeners();
    FocusScope.of(locator<NavHelper>().navigatorKey.currentContext!)
        .requestFocus(FocusNode());
  }
}
