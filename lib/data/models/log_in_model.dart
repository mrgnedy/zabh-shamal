class LogInModel {
  String msg;
  String apiToken;
  LogInData data;

  LogInModel({this.msg, this.apiToken, this.data});

  LogInModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    apiToken = json['api_token'];
    data = json['data'] != null ? new LogInData.fromJson(json['data']) : null;
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

class LogInData {
  int id;
  String name;
  String phone;
  String email;
  String type;
  String emailVerifiedAt;
  String apiToken;
  String createdAt;
  String updatedAt;

  LogInData(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.type,
      this.emailVerifiedAt,
      this.apiToken,
      this.createdAt,
      this.updatedAt});

  LogInData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    type = json['type'];
    emailVerifiedAt = json['email_verified_at'];
    apiToken = json['api_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;

    data['api_token'] = this.apiToken;

    return data;
  }
}
