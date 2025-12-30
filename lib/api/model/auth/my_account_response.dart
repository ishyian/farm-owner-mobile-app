class MyAccountResponse {
  User? user;

  MyAccountResponse({this.user});

  MyAccountResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  int? userId;
  int? status;
  int? countryCode;
  int? mobile;
  String? name;
  String? userName; // Changed from Null? to String?
  String? email;
  String? licenseId; // Changed from Null? to String?
  String? lastLoginLongitude; // Changed from Null? to String?
  String? lastLoginLatitude; // Changed from Null? to String?
  String? emailVerifiedAt; // Changed from Null? to String?
  String? createdAt;
  String? updatedAt; // Changed from Null? to String?
  String? cityId; // Changed from Null? to String?
  String? provinceId; // Changed from Null? to String?
  String? facilityId;
  String? facilityLicenceId; // Changed from Null? to String?
  String? farmName; // Changed from Null? to String?
  String? shopName; // Changed from Null? to String?
  String? firstName; // Changed from Null? to String?
  String? middleName; // Changed from Null? to String?
  String? lastName; // Changed from Null? to String?
  String? clanName; // Changed from Null? to String?
  String? ownerName; // Changed from Null? to String?
  String? nationalId; // Changed from Null? to String?
  String? manualLocation; // Changed from Null? to String?
  String? location; // Changed from Null? to String?
  String? area; // Changed from Null? to String?
  String? geoLocation; // Changed from Null? to String?
  String? latitude; // Changed from Null? to String?
  String? longitude; // Changed from Null? to String?
  String? userTypeId;
  UserType? userType;
  List<String>? permissions; // Changed from List<Null>? to List<String>?

  User({
    this.id,
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
    this.userTypeId,
    this.userType,
    this.permissions,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
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
    userType = json['user_type'] != null ? UserType.fromJson(json['user_type']) : null;
    permissions = json['permissions'] != null ? List<String>.from(json['permissions']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['status'] = status;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['name'] = name;
    data['user_name'] = userName;
    data['email'] = email;
    data['license_id'] = licenseId;
    data['last_login_longitude'] = lastLoginLongitude;
    data['last_login_latitude'] = lastLoginLatitude;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['city_id'] = cityId;
    data['province_id'] = provinceId;
    data['facility_id'] = facilityId;
    data['facility_licence_id'] = facilityLicenceId;
    data['farm_name'] = farmName;
    data['shop_name'] = shopName;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['clan_name'] = clanName;
    data['owner_name'] = ownerName;
    data['national_id'] = nationalId;
    data['manual_location'] = manualLocation;
    data['location'] = location;
    data['area'] = area;
    data['geo_location'] = geoLocation;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['user_type_id'] = userTypeId;
    if (userType != null) {
      data['user_type'] = userType!.toJson();
    }
    if (permissions != null) {
      data['permissions'] = permissions;
    }
    return data;
  }
}

class UserType {
  String? id;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;

  UserType({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  UserType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
