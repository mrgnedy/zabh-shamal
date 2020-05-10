class PackNShredModel {
  String msg;
  Data data;

  PackNShredModel({this.msg, this.data});

  PackNShredModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<Services> services;
  List<Services> packages;
  List<Services> shudders;

  Data({this.services, this.packages, this.shudders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    if (json['packages'] != null) {
      packages = new List<Services>();
      json['packages'].forEach((v) {
        packages.add(new Services.fromJson(v));
      });
    }
    if (json['shudders'] != null) {
      shudders = new List<Services>();
      json['shudders'].forEach((v) {
        shudders.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.packages != null) {
      data['packages'] = this.packages.map((v) => v.toJson()).toList();
    }
    if (this.shudders != null) {
      data['shudders'] = this.shudders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int id;
  int type;
  String name;
  String image;
  String createdAt;
  String updatedAt;

  Services(
      {this.id,
      this.name,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.type});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
