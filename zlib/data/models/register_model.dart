class RegisterModel {
  String msg;
  String apiToken;
  RegisterData data;

  RegisterModel({this.msg, this.apiToken, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    apiToken = json['api_token'];
    data =
        json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['api_token'] = this.apiToken;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class RegisterData {
  String name;
  String phone;
  String email;

  String apiToken;
  String updatedAt;
  String createdAt;
  int id;

  RegisterData(
      {this.name,
      this.phone,
      this.email,
      this.apiToken,
      this.updatedAt,
      this.createdAt,
      this.id});

  RegisterData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    apiToken = json['api_token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;

    data['api_token'] = this.apiToken;
    data['id'] = this.id;
    return data;
  }
}
