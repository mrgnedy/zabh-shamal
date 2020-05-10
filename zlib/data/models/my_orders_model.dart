class MyOrdersModel {
  String msg;
  Data data;

  MyOrdersModel({this.msg, this.data});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
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
  List<Initorders> initorders;
  List<Initorders> finishorders;

  Data({this.initorders, this.finishorders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['initorders'] != null) {
      initorders = new List<Initorders>();
      json['initorders'].forEach((v) {
        initorders.add(new Initorders.fromJson(v));
      });
    }
    if (json['finishorders'] != null) {
      finishorders = new List<Initorders>();
      json['finishorders'].forEach((v) {
        finishorders.add(new Initorders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.initorders != null) {
      data['initorders'] = this.initorders.map((v) => v.toJson()).toList();
    }
    if (this.finishorders != null) {
      data['finishorders'] = this.finishorders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Initorders {
  List<Order> order;
  List<OrderProducts> orderProducts;

  Initorders({this.order, this.orderProducts});

  Initorders.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = new List<Order>();
      json['order'].forEach((v) {
        order.add(new Order.fromJson(v));
      });
    }
    if (json['order_products'] != null) {
      orderProducts = new List<OrderProducts>();
      json['order_products'].forEach((v) {
        orderProducts.add(new OrderProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.map((v) => v.toJson()).toList();
    }
    if (this.orderProducts != null) {
      data['order_products'] =
          this.orderProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int id;
  int userId;
  String name;
  String address;
  String city;
  String lat;
  String lng;
  String phone;
  int paymentType;
  int status;
  String totalPrice;
  int type;
  String createdAt;
  String updatedAt;

  Order(
      {this.id,
      this.userId,
      this.name,
      this.address,
      this.city,
      this.lat,
      this.lng,
      this.phone,
      this.paymentType,
      this.status,
      this.totalPrice,
      this.type,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    lat = json['lat'];
    lng = json['lng'];
    phone = json['phone'];
    paymentType = json['payment_type'];
    status = json['status'];
    totalPrice = json['total_price'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['phone'] = this.phone;
    data['payment_type'] = this.paymentType;
    data['status'] = this.status;
    data['total_price'] = this.totalPrice;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OrderProducts {
  int id;
  int productId;
  int orderId;
  int shudderId;
  int packageId;
  int orderService;
  String qty;
  String notes;
  int price;
  int power;
  String arrivalTime;
  String resturant;
  String createdAt;
  String updatedAt;
  SingleProduct product;

  OrderProducts(
      {this.id,
      this.productId,
      this.orderId,
      this.shudderId,
      this.packageId,
      this.orderService,
      this.qty,
      this.notes,
      this.price,
      this.power,
      this.arrivalTime,
      this.resturant,
      this.createdAt,
      this.updatedAt,
      this.product});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    shudderId = json['shudder_id'];
    packageId = json['package_id'];
    orderService = json['order_service'];
    qty = json['qty'];
    notes = json['notes'];
    price = json['price'];
    power = json['power'];
    arrivalTime = json['arrival_time'];
    resturant = json['resturant'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new SingleProduct.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['shudder_id'] = this.shudderId;
    data['package_id'] = this.packageId;
    data['order_service'] = this.orderService;
    data['qty'] = this.qty;
    data['notes'] = this.notes;
    data['price'] = this.price;
    data['power'] = this.power;
    data['arrival_time'] = this.arrivalTime;
    data['resturant'] = this.resturant;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class SingleProduct {
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

  SingleProduct(
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

  SingleProduct.fromJson(Map<String, dynamic> json) {
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
