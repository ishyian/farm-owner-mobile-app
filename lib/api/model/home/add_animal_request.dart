import 'package:dio/dio.dart';

class AddAnimalRequest {
  String? speciesId;
  String? breedId;
  int? age;
  String? sex;
  String? facilityId;

  AddAnimalRequest({
    this.speciesId,
    this.breedId,
    this.age,
    this.sex,
    this.facilityId,
  });

  FormData toFormData() {
    return FormData.fromMap({
      'species_id': speciesId,
      'breed_id': breedId,
      'age': age,
      'sex': sex,
      'facility_id': facilityId,
    });
  }
}
