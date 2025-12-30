class AddAnimalResponse {
  String? speciesId;
  String? facilityId;
  String? breedId;
  String? age;
  String? sex;
  String? userId;
  String? id;
  String? createdBy;
  String? updatedBy;
  int? animalId;
  DateTime? updatedAt;
  DateTime? createdAt;

  AddAnimalResponse({
    this.speciesId,
    this.facilityId,
    this.breedId,
    this.age,
    this.sex,
    this.userId,
    this.id,
    this.createdBy,
    this.updatedBy,
    this.animalId,
    this.updatedAt,
    this.createdAt,
  });

  factory AddAnimalResponse.fromJson(Map<String, dynamic> json) {
    return AddAnimalResponse(
      speciesId: json['species_id'],
      facilityId: json['facility_id'],
      breedId: json['breed_id'],
      age: json['age'],
      sex: json['sex'],
      userId: json['user_id'],
      id: json['id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      animalId: json['animal_id'],
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
