class AllServicesModel {
  String msg;
  List<Service> data;

  AllServicesModel({this.msg, this.data});

  AllServicesModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Service>();
      json['data'].forEach((v) {
        data.add(new Service.fromJson(v));
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

class Service {
  int id;
  String name;
  String image;
  String createdAt;
  String updatedAt;
  List<Product> product;

  Service(
      {this.id,
      this.name,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.product});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
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

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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
