import 'dart:convert';

import 'package:bots/data/models/product_model.dart';

class OrderModel {
  String name;
  String address;
  int paymentType;
  String lat;
  String lng;
  String city;
  String products;
  String phone;

  OrderModel(
      {this.name,
      this.address,
      this.paymentType,
      this.lat,
      this.lng,
      this.city,
      this.products,
      this.phone});

  OrderModel.fromJson(Map<String, dynamic> jsona) {
    name = jsona['name'];
    address = jsona['address'];
    paymentType = jsona['payment_type'];
    lat = jsona['lat'];
    lng = jsona['lng'];
    city = jsona['city'];
    products = jsona['products'] != null
        ?  json.encode(ProductModel.fromJson(jsona['products']))
        : null;
    phone = jsona['phone'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['payment_type'] = this.paymentType.toString();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['city'] = this.city;
    if (this.products != null) {
      data['products'] =json.encode(this.products);
    }
    data['phone'] = this.phone;
    return data;
  }
}

class ProductsList {
  List<Products> products;

  ProductsList({this.products});

  ProductsList.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
