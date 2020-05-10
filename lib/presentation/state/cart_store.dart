import 'dart:convert';

import 'package:bots/data/models/cart_model.dart';
import 'package:bots/data/models/product_model.dart';
import 'package:bots/data/models/update_model.dart';
import 'package:bots/domain/repo/order_repo_inter.dart';
import 'package:flutter/material.dart';

class CartStore {
  final IOrderRepo orderRepo;
  List cartCounters;
  CartStore(this.orderRepo);
  CartModel cartModel;

  Future<CartModel> getCart(context) async {
    cartModel = await orderRepo.getCart(context);
    print(cartModel.msg);
    return cartModel;
  }

  Future<UpdateCartModel> updateCart(
      BuildContext context, int quantity, int id) async {
    return await orderRepo.updateCart(context, quantity, id);
  }

  Future addToCart(BuildContext context, ProductModel product) async {
    print('Inside adding to cart');
    print('rrrrrrrrrrr ${product.products.first.resturant}');
    return await orderRepo.addToCart(context, product);
  }

  Future makeOrder(BuildContext context, Map<String, String> orderModel,
      dynamic path) async {
    print('Inside making order');
    print(orderModel);
    final res = await orderRepo.makeOrder(context, orderModel, path);
    print(res.stream.listen((onData) {
      print("this is response ${utf8.decode(onData)}");
    }));
    return res;
  }

  Future deleteOrder(BuildContext context, orderID) async {
    return await orderRepo.delOrder(context, orderID);
  }
}
