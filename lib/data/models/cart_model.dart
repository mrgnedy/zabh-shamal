class CartModel {
  String msg;
  List<Data> data;

  CartModel({this.msg, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
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
  int qty;
  int power;
  int totalPrice;
  int productId;
  int packageId;
  int shudderId;
  int orderService;
  String notes;
  String arrivalTime;
  String resturant;
  String sername;
  String shudder;
  String package;
  List<Product> product;

  Data(
      {this.id,
      this.qty,
      this.power,
      this.totalPrice,
      this.productId,
      this.packageId,
      this.shudderId,
      this.orderService,
      this.notes,
      this.arrivalTime,
      this.resturant,
      this.sername,
      this.shudder,
      this.package,
      this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    power = json['power'];
    totalPrice = json['total_price'];
    productId = json['product_id'];
    packageId = json['package_id'];
    shudderId = json['shudder_id'];
    orderService = json['order_service'];
    notes = json['notes'];
    arrivalTime = json['arrival_time'];
    resturant = json['resturant'];
    sername = json['sername'];
    shudder = json['shudder'];
    package = json['package'];
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
    data['qty'] = this.qty;
    data['power'] = this.power;
    data['total_price'] = this.totalPrice;
    data['product_id'] = this.productId;
    data['package_id'] = this.packageId;
    data['shudder_id'] = this.shudderId;
    data['order_service'] = this.orderService;
    data['notes'] = this.notes;
    data['arrival_time'] = this.arrivalTime;
    data['resturant'] = this.resturant;
    data['sername'] = this.sername;
    data['shudder'] = this.shudder;
    data['package'] = this.package;
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
