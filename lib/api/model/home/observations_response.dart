import 'package:weqaa/api/model/home/my_animal_response.dart';

class AnimalScreening {
  String id;
  String animalId;
  String screeningResult;
  String remarks;
  String? updatedBy;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  MyAnimalResponse? animal;
  List<ScreeningSymptom>? symptoms;
  List<ScreeningDisease>? diseases;
  List<ScreeningFile>? files;

  AnimalScreening({
    required this.id,
    required this.animalId,
    required this.screeningResult,
    required this.remarks,
    this.updatedBy,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.animal,
    this.symptoms,
    this.diseases,
    this.files,
  });

  factory AnimalScreening.fromJson(Map<String, dynamic> json) {
    return AnimalScreening(
      id: json['id'] ?? '',
      animalId: json['animal_id'] ?? '',
      screeningResult: json['screening_result'] ?? '',
      remarks: json['remarks'] ?? '',
      updatedBy: json['updated_by'],
      createdBy: json['created_by'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      animal: json['animal'] != null
          ? MyAnimalResponse.fromJson(json['animal'])
          : null,
      symptoms: json['symptoms'] != null
          ? List<ScreeningSymptom>.from(
              json['symptoms'].map((x) => ScreeningSymptom.fromJson(x)))
          : null,
      diseases: json['diseases'] != null
          ? List<ScreeningDisease>.from(
              json['diseases'].map((x) => ScreeningDisease.fromJson(x)))
          : null,
      files: json['files'] != null
          ? List<ScreeningFile>.from(
              json['files'].map((x) => ScreeningFile.fromJson(x)))
          : [],
    );
  }

  static List<AnimalScreening> fromJsonList(List<dynamic>? data) {
    List<AnimalScreening> response = [];

    if (data == null) {
      return response;
    }

    for (var item in data) {
      AnimalScreening animalScreeningResponse =
          AnimalScreening.fromJson(item as Map<String, dynamic>);
      response.add(animalScreeningResponse);
    }

    return response;
  }
}

class ScreeningSymptom {
  String? id;
  String? name;
  String? code;
  String? description;
  int? status;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  ScreeningSymptom({
    this.id,
    this.name,
    this.code,
    this.description,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory ScreeningSymptom.fromJson(Map<String, dynamic> json) {
    return ScreeningSymptom(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      status: json['status'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }
}

class Pivot {
  String? animalScreeningId;
  String? symptomId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Pivot({
    this.animalScreeningId,
    this.symptomId,
    this.createdAt,
    this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      animalScreeningId: json['animal_screening_id'],
      symptomId: json['symptom_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class ScreeningDisease {
  String? id;
  String? name;
  String? diseaseClass;
  String? icdCode;
  String? oieCode;
  String? description;
  String? longDesc;
  String? severity;
  String? labTestRequired;
  int? exceptional;
  int? status;
  String? createdBy;
  String? updatedBy;
  int? notifiable;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  ScreeningDisease({
    this.id,
    this.name,
    this.diseaseClass,
    this.icdCode,
    this.oieCode,
    this.description,
    this.longDesc,
    this.severity,
    this.labTestRequired,
    this.exceptional,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.notifiable,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory ScreeningDisease.fromJson(Map<String, dynamic> json) {
    return ScreeningDisease(
      id: json['id'],
      name: json['name'],
      diseaseClass: json['class'],
      icdCode: json['icd_code'],
      oieCode: json['oie_code'],
      description: json['description'],
      longDesc: json['long_desc'],
      severity: json['severity'],
      labTestRequired: json['lab_test_required'],
      exceptional: json['exceptional'],
      status: json['status'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      notifiable: json['notifiable'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }
}

class ScreeningFile {
  int? id;
  String? animalScreeningId;
  String? filename;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? url;

  ScreeningFile({
    this.id,
    this.animalScreeningId,
    this.filename,
    this.createdAt,
    this.updatedAt,
    this.url,
  });

  factory ScreeningFile.fromJson(Map<String, dynamic> json) {
    return ScreeningFile(
      id: json['id'],
      animalScreeningId: json['animal_screening_id'],
      filename: json['filename'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      url: json['url'],
    );
  }
}

class PostMortem {
  String id;
  String? dateOfPostMortem;
  int? noOfAnimalsScreened;
  int? noOfAnimalsOrgansCollected;
  String? updatedBy;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Detail> details;

  PostMortem({
    required this.id,
    this.dateOfPostMortem,
    this.noOfAnimalsScreened,
    this.noOfAnimalsOrgansCollected,
    this.updatedBy,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    required this.details,
  });

  factory PostMortem.fromJson(Map<String, dynamic> json) {
    return PostMortem(
      id: json['id'] ?? '',
      dateOfPostMortem: json['date_of_post_mortem'],
      noOfAnimalsScreened: json['no_of_animals_screened'],
      noOfAnimalsOrgansCollected: json['no_of_animals_organs_collected'],
      updatedBy: json['updated_by'],
      createdBy: json['created_by'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      details: json['details'] != null
          ? List<Detail>.from(json['details'].map((x) => Detail.fromJson(x)))
          : [],
    );
  }

  static List<PostMortem> fromJsonList(List<dynamic>? data) {
    List<PostMortem> response = [];

    if (data == null) {
      return response;
    }

    for (var item in data) {
      PostMortem postMortemResponse =
          PostMortem.fromJson(item as Map<String, dynamic>);
      response.add(postMortemResponse);
    }

    return response;
  }
}

class Detail {
  String? id;
  String? animalPostMortemId;
  String? animalId;
  String? examinedOrgan;
  String? observation;
  String? carcassCondemnation;
  DateTime? createdAt;
  DateTime? updatedAt;
  MyAnimalResponse? animal;

  Detail({
    this.id,
    this.animalPostMortemId,
    this.animalId,
    this.examinedOrgan,
    this.observation,
    this.carcassCondemnation,
    this.createdAt,
    this.updatedAt,
    this.animal,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      animalPostMortemId: json['animal_post_mortem_id'],
      animalId: json['animal_id'],
      examinedOrgan: json['examined_organ'],
      observation: json['observation'],
      carcassCondemnation: json['carcass_condemnation'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      animal: json['animal'] != null
          ? MyAnimalResponse.fromJson(json['animal'])
          : null,
    );
  }
}
