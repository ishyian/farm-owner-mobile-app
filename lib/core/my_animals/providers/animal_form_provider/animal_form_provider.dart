import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/core/my_animals/models/animal_vaccination_model/animal_vaccination_model.dart';
import 'package:weqaa/core/my_animals/widgets/animal_form_view/document_picker_bottom_sheet.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class AnimalFormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final breedController = TextEditingController();
  final ageController = TextEditingController();
  final nickNameController = TextEditingController();
  final earTagController = TextEditingController();
  final numberOfAnimalsController = TextEditingController();
  final ageGroupController = TextEditingController();
  final remarksController = TextEditingController();
  List<String> sexList = ['male'.tr(), 'female'.tr()];
  final List<String> speciesList = ['dog', 'cat', 'bird'];
  final List<String> animalStatusList = ['available', 'adopted', 'lost'];
  final List<String> breedList = ['labrador', 'german shepherd', 'beagle'];
  final List<AnimalVaccinationModel> vaccinations = [];
  final List<File> documents = [];
  AnimalFormProvider();

  bool _isIndividual = false;
  String? _sex;
  String? _species;
  String? _animalStatus;
  String? _breed;

  bool get isIndividual {
    return _isIndividual;
  }

  void setIsIndividual(bool isIndividual) {
    if (isIndividual == _isIndividual) return;
    _isIndividual = isIndividual;
    ageController.clear();
    if (isIndividual) {
      sexList = ['male'.tr(), 'female'.tr()];
    } else {
      sexList = ['male'.tr(), 'female'.tr(), "mixed".tr()];
    }
    setSex(null);

    formKey.currentState?.reset();
    notifyListeners();
    resetValues();
  }

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

  String? get animalStatus => _animalStatus;

  set animalStatus(String? animalStatus) {
    _animalStatus = animalStatus;
    notifyListeners();
  }

  String? get breed => _breed;
  set breed(String? breed) {
    _breed = breed;
    notifyListeners();
  }

  Future submit() async {
    if (formKey.currentState?.validate() ?? false) {
      // locator<NavHelper>().pushAndRemoveUntilFirst(const StartView());
    }
  }

  void addVaccination() {
    final vaccination = AnimalVaccinationModel();
    vaccinations.add(vaccination);
    notifyListeners();
  }

  void removeVaccination(int index) {
    vaccinations.removeAt(index);
    notifyListeners();
  }

  void onAddDocument() {
    DocumentPickerBottomSheet.show(onPickedFile: (files) async {
      locator<NavHelper>().pop();
      addDocuments(files);
    });
  }

  void addDocuments(List<File> documents) {
    this.documents.addAll(documents);
    notifyListeners();
  }

  void removeDocument(int index) {
    documents.removeAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    breedController.dispose();
    ageController.dispose();
    nickNameController.dispose();
    earTagController.dispose();
    numberOfAnimalsController.dispose();
    ageGroupController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  void resetValues() {
    breedController.clear();
    ageController.clear();
    nickNameController.clear();
    earTagController.clear();
    numberOfAnimalsController.clear();
    ageGroupController.clear();
    remarksController.clear();
    vaccinations.clear();
    documents.clear();
    _sex = null;
    _species = null;
    _animalStatus = null;
    _breed = null;
    notifyListeners();
    FocusScope.of(locator<NavHelper>().navigatorKey.currentContext!)
        .requestFocus(FocusNode());
  }
}
