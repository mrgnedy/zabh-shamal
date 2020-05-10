import 'dart:convert';

import 'package:bots/core/api_utils.dart';
import 'package:bots/data/models/cart_model.dart';
import 'package:bots/data/models/product_model.dart';
import 'package:bots/data/models/update_model.dart';
import 'package:bots/domain/repo/order_repo_inter.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
// import 'package:http/http.dart';

class CartRepo implements IOrderRepo {
  @override
  Future<CartModel> getCart(context) async {
    final response = await APIs.getRequest(context, APIs.getCartEP);
    if (response != null) {
      return CartModel.fromJson(response);
    } else
      throw Exception();
  }

  @override
  Future<UpdateCartModel> updateCart(context, quantity, id) async {
    String url = APIs.updateCartEP;
    Map<String, dynamic> body = {
      'order_product': id.toString(),
      'qty': quantity.toString()
    };
    final response = await APIs.postRequest(context, url, body);
    if (response != null) {
      return UpdateCartModel.fromJson(response);
    } else
      throw Exception();
  }

  @override
  Future addToCart(BuildContext context, ProductModel productModel) async {
    String url = APIs.addToCartEP;
    Map<String, dynamic> body = {
      'products': json.encode(productModel.toJson())
    };
    print(body);
    print('cartttt');
    final response = await APIs.postRequest(context, url, body);
    if (response != null) {
      print('بطيخ');
      return response;
    }
    throw Exception();
  }

  @override
  Future<StreamedResponse> makeOrder(BuildContext context,
      Map<String, String> orderModel, dynamic path) async {
    Uri url = Uri.parse(APIs.addOrderEP);
    // Map<String, String> body = orderModel.toJson();
    final response = MultipartRequest('post', url);
    response.headers.addAll(<String, String>{
      "Authorization":
          "Bearer ${APIs.token}"
    });
    
    response.fields.addAll(orderModel);
    if(path != null)
    response.files.add(await MultipartFile.fromPath('image', path));
    // print(path);
    final res = await response.send();
    
    // res.stream.listen((onData){
    //   print(utf8.decode(onData));
    // });
    return res;
  }

  @override
  Future delOrder(BuildContext context, orderID) async {
    String url = APIs.deleteOrderEP;
    Map<String, dynamic> body = {"order_product_id": orderID};
    final response = await APIs.postRequest(context, url, body);
    if (response != null)
      return response;
    else
      return null;
  }
}
