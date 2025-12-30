import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weqaa/core/my_animals/widgets/animal_form_view/document_picker_bottom_sheet.dart';
import 'package:weqaa/utils/helpers/locator.dart';
import 'package:weqaa/utils/helpers/nav_helper.dart';

class IncidentFormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final remarksController = TextEditingController();
  final List<String> animalBatchIds = ['dog', 'cat', 'bird'];
  final List<String> animalStatusList = ['available', 'adopted', 'lost'];
  final List<String> symptoms = [
    'labrador',
    'german shepherd',
    'beagle',
    'available',
    'adopted',
    'lost',
    'dog',
    'cat',
    'bird'
  ];
  final List<File> documents = [];

  IncidentFormProvider();

  List<String> _selectedSymptoms = [];
  String? _animalBatchId;
  String? _animalStatus;
  Map<int, List<File>> _symptomsFiles = {};

  String? get animalBatchId => _animalBatchId;

  set animalBatchId(String? animalBatchId) {
    _animalBatchId = animalBatchId;
    notifyListeners();
  }

  List<String> get selectedSymptoms => _selectedSymptoms;
  set selectedSymptoms(List<String> selectedSymptoms) {
    _selectedSymptoms = selectedSymptoms;
    notifyListeners();
  }

  String? get animalStatus => _animalStatus;

  set animalStatus(String? animalStatus) {
    _animalStatus = animalStatus;
    notifyListeners();
  }

  Future submit() async {
    if (formKey.currentState?.validate() ?? false) {
      // locator<NavHelper>().pushAndRemoveUntilFirst(const StartView());
    }
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
}
