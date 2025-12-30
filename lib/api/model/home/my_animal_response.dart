import 'package:weqaa/utils/helpers/dynamic.dart';

class MyAnimalResponse {
  String? id;
  int? animalId;
  String? userId;
  String? speciesId;
  String? breedId;
  bool? canCreateBatch;
  int? age;
  String? sex;
  String? nickname;
  String? earTag;
  String? status;
  String? remarks;
  String? registrationType;
  String? facilityName;
  String? updatedBy;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic? countryId;
  dynamic? scientificName;
  dynamic? animalIdentification;
  dynamic? pedigree;
  dynamic? branding;
  dynamic? rfid;
  dynamic? microchip;
  dynamic? exoticAnimal;
  dynamic? numberOfMales;
  dynamic? numberOfFemales;
  dynamic? numberOfAnimals;
  dynamic? unit;
  dynamic? unitValue;
  dynamic? area;
  dynamic? provinceId;
  User? user;
  Species? species;
  Breed? breed;
  List<Vaccinations>? vaccinations;
  List<dynamic>? files;
  List<AnimalImage>? images;

  MyAnimalResponse(
      {this.id,
        this.animalId,
        this.userId,
        this.speciesId,
        this.breedId,
        this.canCreateBatch,
        this.age,
        this.sex,
        this.nickname,
        this.earTag,
        this.status,
        this.remarks,
        this.registrationType,
        this.facilityName,
        this.updatedBy,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.countryId,
        this.scientificName,
        this.animalIdentification,
        this.pedigree,
        this.branding,
        this.rfid,
        this.microchip,
        this.exoticAnimal,
        this.numberOfMales,
        this.numberOfFemales,
        this.numberOfAnimals,
        this.unit,
        this.unitValue,
        this.area,
        this.provinceId,
        this.user,
        this.species,
        this.breed,
        this.vaccinations,
        this.files});

  MyAnimalResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animalId = json['animal_id'];
    userId = json['user_id'];
    speciesId = json['species_id'];
    breedId = json['breed_id'];
    canCreateBatch = dynamicToBool(json['can_create_batch']);
    age = json['age'];
    sex = json['sex'];
    nickname = json['nickname'];
    earTag = json['ear_tag'];
    status = json['status'];
    remarks = json['remarks'];
    registrationType = json['registration_type'];
    facilityName = json['facility_name'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryId = json['country_id'];
    scientificName = json['scientific_name'];
    animalIdentification = json['animal_identification'];
    pedigree = json['pedigree'];
    branding = json['branding'];
    rfid = json['rfid'];
    microchip = json['microchip'];
    exoticAnimal = json['exotic_animal'];
    numberOfMales = json['number_of_males'];
    numberOfFemales = json['number_of_females'];
    numberOfAnimals = json['number_of_animals'];
    unit = json['unit'];
    unitValue = json['unit_value'];
    area = json['area'];
    provinceId = json['province_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    species = json['species'] != null ? Species.fromJson(json['species']) : null;
    breed = json['breed'] != null ? Breed.fromJson(json['breed']) : null;
    if (json['vaccinations'] != null) {
      vaccinations = <Vaccinations>[];
      json['vaccinations'].forEach((v) {
        vaccinations!.add(Vaccinations.fromJson(v));
      });
    }
    files = json['files'];
    images = json['images'] != null
        ? List<AnimalImage>.from(
            json['images'].map((x) => AnimalImage.fromJson(x)))
        : [];
  }

  static List<MyAnimalResponse> fromJsonList(List<dynamic>? data){
    List<MyAnimalResponse> response = [];

    if(data == null){
      return response;
    }

    for(var item in data){
      MyAnimalResponse myAnimalResponse = MyAnimalResponse.fromJson(item as Map<String, dynamic>);
      response.add(myAnimalResponse);
    }

    return response;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['animal_id'] = this.animalId;
    data['user_id'] = this.userId;
    data['species_id'] = this.speciesId;
    data['breed_id'] = this.breedId;
    data['can_create_batch'] = this.canCreateBatch;
    data['age'] = this.age;
    data['sex'] = this.sex;
    data['nickname'] = this.nickname;
    data['ear_tag'] = this.earTag;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['registration_type'] = this.registrationType;
    data['facility_name'] = this.facilityName;
    data['updated_by'] = this.updatedBy;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country_id'] = this.countryId;
    data['scientific_name'] = this.scientificName;
    data['animal_identification'] = this.animalIdentification;
    data['pedigree'] = this.pedigree;
    data['branding'] = this.branding;
    data['rfid'] = this.rfid;
    data['microchip'] = this.microchip;
    data['exotic_animal'] = this.exoticAnimal;
    data['number_of_males'] = this.numberOfMales;
    data['number_of_females'] = this.numberOfFemales;
    data['number_of_animals'] = this.numberOfAnimals;
    data['unit'] = this.unit;
    data['unit_value'] = this.unitValue;
    data['area'] = this.area;
    data['province_id'] = this.provinceId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.species != null) {
      data['species'] = this.species!.toJson();
    }
    if (this.breed != null) {
      data['breed'] = this.breed!.toJson();
    }
    if (this.vaccinations != null) {
      data['vaccinations'] = this.vaccinations!.map((v) => v.toJson()).toList();
    }
    if (this.files != null) {
      data['files'] = this.files;
    }
    return data;
  }
}

class User {
  String? id;
  int? userId;
  bool? status;
  int? countryCode;
  int? mobile;
  String? name;
  String? userName;
  String? email;
  String? licenseId;
  String? lastLoginLongitude;
  String? lastLoginLatitude;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? cityId;
  String? provinceId;
  String? facilityId;
  String? facilityLicenceId;
  String? farmName;
  String? shopName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? clanName;
  String? ownerName;
  String? nationalId;
  String? manualLocation;
  String? location;
  String? area;
  String? geoLocation;
  String? latitude;
  String? longitude;
  String? userTypeId;

  User(
      {this.id,
        this.userId,
        this.status,
        this.countryCode,
        this.mobile,
        this.name,
        this.userName,
        this.email,
        this.licenseId,
        this.lastLoginLongitude,
        this.lastLoginLatitude,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.cityId,
        this.provinceId,
        this.facilityId,
        this.facilityLicenceId,
        this.farmName,
        this.shopName,
        this.firstName,
        this.middleName,
        this.lastName,
        this.clanName,
        this.ownerName,
        this.nationalId,
        this.manualLocation,
        this.location,
        this.area,
        this.geoLocation,
        this.latitude,
        this.longitude,
        this.userTypeId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    status = dynamicToBool(json['status']);
    countryCode = json['country_code'];
    mobile = json['mobile'];
    name = json['name'];
    userName = json['user_name'];
    email = json['email'];
    licenseId = json['license_id'];
    lastLoginLongitude = json['last_login_longitude'];
    lastLoginLatitude = json['last_login_latitude'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cityId = json['city_id'];
    provinceId = json['province_id'];
    facilityId = json['facility_id'];
    facilityLicenceId = json['facility_licence_id'];
    farmName = json['farm_name'];
    shopName = json['shop_name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    clanName = json['clan_name'];
    ownerName = json['owner_name'];
    nationalId = json['national_id'];
    manualLocation = json['manual_location'];
    location = json['location'];
    area = json['area'];
    geoLocation = json['geo_location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userTypeId = json['user_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['license_id'] = this.licenseId;
    data['last_login_longitude'] = this.lastLoginLongitude;
    data['last_login_latitude'] = this.lastLoginLatitude;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['city_id'] = this.cityId;
    data['province_id'] = this.provinceId;
    data['facility_id'] = this.facilityId;
    data['facility_licence_id'] = this.facilityLicenceId;
    data['farm_name'] = this.farmName;
    data['shop_name'] = this.shopName;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['clan_name'] = this.clanName;
    data['owner_name'] = this.ownerName;
    data['national_id'] = this.nationalId;
    data['manual_location'] = this.manualLocation;
    data['location'] = this.location;
    data['area'] = this.area;
    data['geo_location'] = this.geoLocation;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['user_type_id'] = this.userTypeId;
    return data;
  }
}

class Species {
  String? id;
  String? name;
  String? scientificName;
  String? description;
  bool? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  Species(
      {this.id,
        this.name,
        this.scientificName,
        this.description,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  Species.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    scientificName = json['scientific_name'];
    description = json['description'];
    status = dynamicToBool(json['status']);
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  static List<Species> fromJsonList(Map<String, dynamic>? model){
    List<Species> response = [];

    if(model == null){
      return response;
    }

    for(var item in (model["data"] as List<dynamic>)){
      Species speciesResponse = Species.fromJson(item as Map<String, dynamic>);
      response.add(speciesResponse);
    }

    return response;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['scientific_name'] = this.scientificName;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Breed {
  String? id;
  String? speciesId;
  String? breed;
  int? lifespan;
  String? description;
  bool? canCreateBatch;
  bool? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  Breed(
      {this.id,
        this.speciesId,
        this.breed,
        this.lifespan,
        this.description,
        this.canCreateBatch,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  Breed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    speciesId = json['species_id'];
    breed = json['breed'];
    lifespan = json['lifespan'];
    description = json['description'];
    canCreateBatch = dynamicToBool(json['can_create_batch']);
    status = dynamicToBool(json['status']);
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  static List<Breed> fromJsonList(Map<String, dynamic>? model){
    List<Breed> response = [];

    if(model == null){
      return response;
    }

    for(var item in (model["data"] as List<dynamic>)){
      Breed breedResponse = Breed.fromJson(item as Map<String, dynamic>);
      response.add(breedResponse);
    }

    return response;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['species_id'] = this.speciesId;
    data['breed'] = this.breed;
    data['lifespan'] = this.lifespan;
    data['description'] = this.description;
    data['can_create_batch'] = this.canCreateBatch;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Vaccinations {
  String? id;
  String? vaccineCode;
  String? genericName;
  String? brandName;
  String? strength;
  String? quantity;
  int? liveVaccine;
  String? administrationRoute;
  String? dosage;
  int? interval;
  String? exceptional;
  String? instructions;
  String? description;
  int? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Vaccinations(
      {this.id,
        this.vaccineCode,
        this.genericName,
        this.brandName,
        this.strength,
        this.quantity,
        this.liveVaccine,
        this.administrationRoute,
        this.dosage,
        this.interval,
        this.exceptional,
        this.instructions,
        this.description,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Vaccinations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vaccineCode = json['vaccine_code'];
    genericName = json['generic_name'];
    brandName = json['brand_name'];
    strength = json['strength'];
    quantity = json['quantity'];
    liveVaccine = json['live_vaccine'];
    administrationRoute = json['administration_route'];
    dosage = json['dosage'];
    interval = json['interval'];
    exceptional = json['exceptional'];
    instructions = json['instructions'];
    description = json['description'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['vaccine_code'] = this.vaccineCode;
    data['generic_name'] = this.genericName;
    data['brand_name'] = this.brandName;
    data['strength'] = this.strength;
    data['quantity'] = this.quantity;
    data['live_vaccine'] = this.liveVaccine;
    data['administration_route'] = this.administrationRoute;
    data['dosage'] = this.dosage;
    data['interval'] = this.interval;
    data['exceptional'] = this.exceptional;
    data['instructions'] = this.instructions;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? animalId;
  String? vaccinationId;
  String? dueDate;
  String? vaccinationDoneOnDate;
  int? isDone;

  Pivot(
      {this.animalId,
        this.vaccinationId,
        this.dueDate,
        this.vaccinationDoneOnDate,
        this.isDone});

  Pivot.fromJson(Map<String, dynamic> json) {
    animalId = json['animal_id'];
    vaccinationId = json['vaccination_id'];
    dueDate = json['due_date'];
    vaccinationDoneOnDate = json['vaccination_done_on_date'];
    isDone = json['is_done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['animal_id'] = this.animalId;
    data['vaccination_id'] = this.vaccinationId;
    data['due_date'] = this.dueDate;
    data['vaccination_done_on_date'] = this.vaccinationDoneOnDate;
    data['is_done'] = this.isDone;
    return data;
  }
}

class AnimalImage {
  int? id;
  String? animalId;
  String? filename;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? url;

  AnimalImage({
    this.id,
    this.animalId,
    this.filename,
    this.createdAt,
    this.updatedAt,
    this.url,
  });

  factory AnimalImage.fromJson(Map<String, dynamic> json) {
    return AnimalImage(
      id: json['id'],
      animalId: json['animal_id'],
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