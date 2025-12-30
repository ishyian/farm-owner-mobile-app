class UserTypeResponse {
  String? id;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;

  UserTypeResponse(
      {this.id, this.title, this.description, this.createdAt, this.updatedAt});

  UserTypeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  static List<UserTypeResponse> fromJsonList(List<dynamic>? data){
    List<UserTypeResponse> response = [];

    if(data == null){
      return response;
    }
    for(var item in data){
      UserTypeResponse userTypeResponse = UserTypeResponse.fromJson(item as Map<String, dynamic>);
      response.add(userTypeResponse);
    }
    return response;
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}