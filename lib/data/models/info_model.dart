class InfoModel {
  String msg;
  InfoData  data;

  InfoModel({this.msg, this.data});

  InfoModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new InfoData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class InfoData {
  int id;
  String siteName;
  String siteLogo;
  String aboutUs;
  String conditions;
  String whatsapp;
  String phone;
  String shopping;
  String createdAt;
  String updatedAt;

  InfoData(
      {this.id,
      this.siteName,
      this.siteLogo,
      this.aboutUs,
      this.conditions,
      this.shopping,
      this.whatsapp,
      this.phone,
      this.createdAt,
      this.updatedAt});

  InfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['site_name'];
    siteLogo = json['site_logo'];
    aboutUs = json['about_us'];
    conditions = json['conditions'];
    whatsapp = json['whatsapp'];
    phone = json['phone'];
    shopping = json['shopping'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_name'] = this.siteName;
    data['site_logo'] = this.siteLogo;
    data['about_us'] = this.aboutUs;
    data['conditions'] = this.conditions;
    data['shopping'] = this.shopping;
    data['whatsapp'] = this.whatsapp;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
