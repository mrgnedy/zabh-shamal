class OffersModel {
  String msg;
  List<Data> data;

  OffersModel({this.msg, this.data});

  OffersModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String image;
  String age;
  String weight;
  int type;
  String name;
  String desc;
  int serviceId;
  int price;
  int priceAfteroffer;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.image,
      this.age,
      this.weight,
      this.type,
      this.name,
      this.desc,
      this.serviceId,
      this.price,
      this.priceAfteroffer,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    age = json['age'];
    weight = json['weight'];
    type = json['type'];
    name = json['name'];
    desc = json['desc'];
    serviceId = json['service_id'];
    price = json['price'];
    priceAfteroffer = json['price_afteroffer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['type'] = this.type;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['service_id'] = this.serviceId;
    data['price'] = this.price;
    data['price_afteroffer'] = this.priceAfteroffer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
