class LoginResponse {
  String? accessToken;
  User? user;
  String? tokenType;
  int? expiresIn;

  LoginResponse({this.accessToken, this.user, this.tokenType, this.expiresIn});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = accessToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
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
  dynamic userName;
  String? email;
  dynamic licenseId;
  dynamic lastLoginLongitude;
  dynamic lastLoginLatitude;
  dynamic emailVerifiedAt;
  String? createdAt;
  dynamic updatedAt;
  dynamic cityId;
  dynamic provinceId;
  String? facilityId;
  dynamic facilityLicenceId;
  dynamic farmName;
  dynamic shopName;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic clanName;
  dynamic ownerName;
  dynamic nationalId;
  dynamic manualLocation;
  dynamic location;
  dynamic area;
  dynamic geoLocation;
  dynamic latitude;
  dynamic longitude;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
