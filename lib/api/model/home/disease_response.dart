import 'package:weqaa/utils/helpers/dynamic.dart';

class Disease {
  String? id;
  String? name;
  String? icdCode;
  String? oieCode;
  String? description;
  String? longDesc;
  String? severity;
  List<Symptom>? symptoms;
  List<dynamic>? testTypes;
  bool? status;
  bool? notifiable;
  String? created;

  Disease({
    this.id,
    this.name,
    this.icdCode,
    this.oieCode,
    this.description,
    this.longDesc,
    this.severity,
    this.symptoms,
    this.testTypes,
    this.status,
    this.notifiable,
    this.created,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['id'],
      name: json['name'],
      icdCode: json['icd_code'],
      oieCode: json['oie_code'],
      description: json['description'],
      longDesc: json['long_desc'],
      severity: json['severity'],
      symptoms: json['symptoms'] != null
          ? (json['symptoms'] as List<dynamic>)
              .map((item) => Symptom.fromJson(item))
              .toList()
          : [],
      testTypes: json['test_types'],
      status: json['status'],
      notifiable: json['notifiable'],
      created: json['created'],
    );
  }

  static List<Disease> fromJsonList(Map<String, dynamic>? json) {
    if (json != null && json['data'] != null) {
      List<dynamic> dataList = json['data'];
      return dataList.map((item) => Disease.fromJson(item)).toList();
    }
    return [];
  }

  @override
  String toString() {
    return name ?? "";
  }
}

class Symptom {
  String? id;
  String? name;
  String? code;
  String? description;
  bool? status;
  String? created;

  Symptom({
    this.id,
    this.name,
    this.code,
    this.description,
    this.status,
    this.created,
  });

  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      status: dynamicToBool(json['status']),
      created: json['created'],
    );
  }

  static List<Symptom> fromJsonList(Map<String, dynamic>? json) {
    if (json != null && json['data'] != null) {
      List<dynamic> dataList = json['data'];
      return dataList.map((item) => Symptom.fromJson(item)).toList();
    }
    return [];
  }

  @override
  String toString() {
    return name ?? "";
  }
}
