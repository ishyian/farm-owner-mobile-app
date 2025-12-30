import 'package:dio/dio.dart';

class AddAnimalScreeningRequest {
  String? animalId;
  String? screeningResult;
  String? remarks;
  List<String>? symptoms;
  List<String>? diseases;
  List<Map<String, dynamic>>? symptomImages;
  List<MultipartFile>? files;

  AddAnimalScreeningRequest({
    this.animalId,
    this.screeningResult,
    this.remarks,
    this.symptoms,
    this.diseases,
    this.symptomImages,
    this.files,
  });

  FormData toFormData() {
    final formData = FormData.fromMap({
      'animal_id': animalId,
      'screening_result': screeningResult?.toLowerCase(),
      'remarks': remarks
    });

    if (symptoms != null) {
      for (var i = 0; i < symptoms!.length; i++) {
        formData.fields.add(MapEntry('symptoms[$i]', symptoms![i]));
      }
    }

    if (diseases != null) {
      for (var i = 0; i < diseases!.length; i++) {
        formData.fields.add(MapEntry('diseases[$i]', diseases![i]));
      }
    }

    if (files != null) {
      for (var i = 0; i < files!.length; i++) {
        formData.files.add(MapEntry('files[$i]', files![i]));
      }
    }

    if (symptomImages != null) {
      for (var i = 0; i < symptomImages!.length; i++) {
        final symptomImage = symptomImages![i];
        formData.fields.add(MapEntry(
            'symptom_images[$i][symptom_id]', symptomImage['symptom_id']));

        final images = symptomImage['images'] as List<MultipartFile>?;
        if (images != null) {
          for (var j = 0; j < images.length; j++) {
            formData.files
                .add(MapEntry('symptom_images[$i][images][$j]', images[j]));
          }
        }
      }
    }

    return formData;
  }
}
