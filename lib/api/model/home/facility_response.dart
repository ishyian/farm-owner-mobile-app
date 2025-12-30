class Facility {
  String? id;
  int? facilityId;
  String? facilityName;
  String? ownerName;
  String? nationalId;
  String? city;
  String? province;
  int? cityId;
  int? provinceId;
  String? facilityLocation;
  String? geoLocation;
  String? mobile;
  String? allocatedSystem;
  String? area;
  String? description;
  String? licenceId;
  String? adminEmail;
  String? created;

  Facility({
    this.id,
    this.facilityId,
    this.facilityName,
    this.ownerName,
    this.nationalId,
    this.city,
    this.province,
    this.cityId,
    this.provinceId,
    this.facilityLocation,
    this.geoLocation,
    this.mobile,
    this.allocatedSystem,
    this.area,
    this.description,
    this.licenceId,
    this.adminEmail,
    this.created,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'],
      facilityId: json['facility_id'],
      facilityName: json['facility_name'],
      ownerName: json['owner_name'],
      nationalId: json['national_id'],
      city: json['city'],
      province: json['province'],
      cityId: json['city_id'],
      provinceId: json['province_id'],
      facilityLocation: json['facility_location'],
      geoLocation: json['geo_location'],
      mobile: json['mobile'],
      allocatedSystem: json['allocated_system'],
      area: json['area'],
      description: json['description'],
      licenceId: json['licence_id'],
      adminEmail: json['admin_email'],
      created: json['created'],
    );
  }

  static List<Facility> fromJsonList(Map<String, dynamic>? json) {
    if (json != null && json['data'] != null) {
      List<dynamic> dataList = json['data'];
      return dataList.map((item) => Facility.fromJson(item)).toList();
    }
    return [];
  }
}