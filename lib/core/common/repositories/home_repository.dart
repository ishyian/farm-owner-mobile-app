import 'package:dio/dio.dart';
import 'package:weqaa/api/model/home/add_animal_request.dart';
import 'package:weqaa/api/model/home/add_animal_response.dart';
import 'package:weqaa/api/model/home/add_animal_screening_request.dart';
import 'package:weqaa/api/model/home/add_postmortem_request.dart';
import 'package:weqaa/api/model/home/disease_response.dart';
import 'package:weqaa/api/model/home/facility_response.dart';
import 'package:weqaa/api/model/home/my_animal_response.dart';
import 'package:weqaa/api/model/home/observations_response.dart';
import 'package:weqaa/constants/api_constants.dart';
import 'package:weqaa/core/common/repositories/BaseRepository.dart';

class HomeRepository extends BaseRepository {
  Future<List<MyAnimalResponse>> getAnimals(bool canCreateBatch) async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.animalList}?${ApiConstant.canCreateBatch}=$canCreateBatch',
      );

      return MyAnimalResponse.fromJsonList(response.data);
    } catch (e) {
      throw Exception('Error fetching animal list and error is $e');
    }
  }

  Future<MyAnimalResponse> getAnimalById(String id) async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.animalList}/$id',
      );

      return MyAnimalResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Error fetching animal by id and error is $e');
    }
  }

  Future<AddAnimalResponse> addAnimalRequest(AddAnimalRequest request) async {
    try {
      Response<dynamic> response = await httpHandler.post(
          url: '$baseUrl${ApiConstant.animalList}',
          data: {},
          formData: request.toFormData());

      return AddAnimalResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Error adding animal and error is $e');
    }
  }

  Future<PostMortem> addPostMortem(AddPostMortemRequest request) async {
    try {
      Response<dynamic> response = await httpHandler.post(
          url: '$baseUrl${ApiConstant.postMortemList}', data: request.toJson());

      return PostMortem.fromJson(response.data);
    } catch (e) {
      throw Exception('Error adding post mortem and error is $e');
    }
  }

  Future<List<Species>> getSpecies() async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.speciesList}',
      );

      return Species.fromJsonList(response.data);
    } catch (e) {
      throw Exception('Error fetching species list and error is $e');
    }
  }

  Future<List<Breed>> getBreeds() async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.breedList}',
      );

      return Breed.fromJsonList(response.data);
    } catch (e) {
      throw Exception('Error fetching breed list and error is $e');
    }
  }

  Future<List<Disease>> getDiseases() async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.diseaseList}',
      );

      return Disease.fromJsonList(response.data);
    } catch (e) {
      throw Exception('Error fetching diseases list and error is $e');
    }
  }

  Future<List<Symptom>> getSymptoms() async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.symptomList}',
      );

      return Symptom.fromJsonList(response.data);
    } catch (e) {
      throw Exception('Error fetching symptom list and error is $e');
    }
  }

  Future<List<Facility>> getFacilities() async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.facilityList}',
      );

      return Facility.fromJsonList(response.data);
    } catch (e) {
      throw Exception('Error fetching facility list and error is $e');
    }
  }

  Future<List<AnimalScreening>> getAnimalScreenings() async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.animalScreeningList}',
      );

      return AnimalScreening.fromJsonList(response.data);
    } catch (e) {
      throw Exception('Error fetching animal screening list and error is $e');
    }
  }

  Future<List<PostMortem>> getPostMortems() async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.postMortemList}',
      );

      return PostMortem.fromJsonList(response.data);
    } catch (e) {
      throw Exception('Error fetching post mortem list and error is $e');
    }
  }

  Future<PostMortem> getPostMortemById(String id) async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.postMortemList}/$id',
      );

      return PostMortem.fromJson(response.data);
    } catch (e) {
      throw Exception('Error fetching post mortem detail and error is $e');
    }
  }

  Future<AnimalScreening> getAnimalScreeningById(String id) async {
    try {
      Response<dynamic> response = await httpHandler.get(
        url: '$baseUrl${ApiConstant.animalScreeningList}/$id',
      );

      return AnimalScreening.fromJson(response.data);
    } catch (e) {
      throw Exception('Error fetching animal screening detail and error is $e');
    }
  }

  Future<AnimalScreening> addAnimalScreening(
      AddAnimalScreeningRequest request) async {
    try {
      Response<dynamic> response = await httpHandler.post(
          url: '$baseUrl${ApiConstant.animalScreeningList}',
          data: {},
          formData: request.toFormData());

      return AnimalScreening.fromJson(response.data);
    } catch (e) {
      throw Exception('Error adding animal screening and error is $e');
    }
  }
}