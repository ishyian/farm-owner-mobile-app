import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/api/model/home/add_animal_screening_request.dart';
import 'package:weqaa/api/model/home/disease_response.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/api/model/home/observations_response.dart';
import 'package:weqaa/core/common/repositories/home_repository.dart';
import 'package:weqaa/core/my_animals/widgets/animal_form_view/document_picker_bottom_sheet.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class InitialScreeningFormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final remarksController = TextEditingController();
  final HomeRepository homeRepository = locator<HomeRepository>();

  List<MyAnimalResponse> animals = [];
  final List<String> screeningResultList = ['Pass', 'Fail'];
  List<Symptom> symptoms = [];
  List<Disease> diseases = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<File> documents = [];

  InitialScreeningFormProvider();

  List<Symptom> _selectedSymptoms = [];
  List<Disease> _selectedDiseases = [];
  String? _animalBatchId;
  String? _animalStatus;
  Map<int, List<File>> _symptomsFiles = {};

  String? get animalBatchId => _animalBatchId;

  set animalBatchId(String? animalBatchId) {
    _animalBatchId = animalBatchId;
    notifyListeners();
  }

  List<Symptom> get selectedSymptoms => _selectedSymptoms;

  set selectedSymptoms(List<Symptom> selectedSymptoms) {
    _selectedSymptoms = selectedSymptoms;
    notifyListeners();
  }

  List<Disease> get selectedDiseases => _selectedDiseases;

  set selectedDiseases(List<Disease> selectedDiseases) {
    _selectedDiseases = selectedDiseases;
    notifyListeners();
  }

  String? get screeningResult => _animalStatus;

  set screeningResult(String? animalStatus) {
    _animalStatus = animalStatus;
    notifyListeners();
  }

  Future submit() async {
    if (formKey.currentState?.validate() ?? false) {
      AddAnimalScreeningRequest request = AddAnimalScreeningRequest(
          animalId: animalBatchId,
          screeningResult: screeningResult,
          remarks: remarksController.text,
          symptoms: _selectedSymptoms.map((s) => s.id.toString()).toList(),
          diseases: _selectedDiseases.map((d) => d.id.toString()).toList());

      List<MultipartFile> files = [];
      for (var file in documents) {
        files.add(await MultipartFile.fromFile(file.path));
      }
      request.files = files;
      request.symptomImages = _symptomsFiles.entries.map((entry) {
        final symptomId = entry.key;
        final files = entry.value;
        return {
          'symptom_id': symptoms[symptomId].id,
          'images': files
              .map((file) => MultipartFile.fromFileSync(file.path))
              .toList(),
        };
      }).toList();
      addScreening(request);
    }
  }

  Future<void> addScreening(AddAnimalScreeningRequest requestModel) async {
    isLoading = true;
    AnimalScreening screening =
        await homeRepository.addAnimalScreening(requestModel);
    isLoading = false;
    resetValues();
    locator<NavHelper>().pop();
  }

  Future<void> fetchCommonData() async {
    isLoading = true;
    symptoms = await homeRepository.getSymptoms();
    diseases = await homeRepository.getDiseases();
    animals = await homeRepository.getAnimals(false);
    isLoading = false;
  }

  @override
  void dispose() {
    remarksController.dispose();
    super.dispose();
  }

  void onAddDocument() {
    DocumentPickerBottomSheet.show(onPickedFile: (files) {
      locator<NavHelper>().pop();
      addDocuments(files);
    });
  }

  void addDocuments(List<File> files) {
    documents.addAll(files);
    notifyListeners();
  }

  void removeDocument(int index) {
    documents.removeAt(index);
    notifyListeners();
  }

  Map<int, List<File>> get symptomsFiles => _symptomsFiles;

  void setSymptomsFiles(Map<int, List<File>> symptomsFiles) {
    _symptomsFiles = symptomsFiles;
    notifyListeners();
  }

  void onAddSymptomFilePressed(int symptomIndex) {
    DocumentPickerBottomSheet.show(
        isMedia: true,
        onPickedFile: (file) {
          locator<NavHelper>().pop();
          addSymptomFiles(symptomIndex, file);
        });
  }

  void addSymptomFiles(int symptomIndex, List<File> files) {
    if (_symptomsFiles.containsKey(symptomIndex)) {
      (_symptomsFiles[symptomIndex] as List).addAll(files);
    } else {
      _symptomsFiles[symptomIndex] = files;
    }
    notifyListeners();
  }

  void removeSymptomFile(int symptomIndex, int fileIndex) {
    if (_symptomsFiles.containsKey(symptomIndex) &&
        _symptomsFiles[symptomIndex]!.length > fileIndex) {
      (_symptomsFiles[symptomIndex] as List).removeAt(fileIndex);
    }
    notifyListeners();
  }

  void resetValues() {
    _symptomsFiles = {};
    _selectedDiseases = [];
    _selectedSymptoms = [];
    _animalBatchId = null;
    _animalStatus = null;
    remarksController.clear();
    documents = [];
    notifyListeners();
    FocusScope.of(locator<NavHelper>().navigatorKey.currentContext!)
        .requestFocus(FocusNode());
  }
}
