import 'package:bots/data/models/cart_model.dart';
import 'package:bots/data/models/product_model.dart';
import 'package:bots/data/models/update_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

abstract class IOrderRepo {
  Future<CartModel> getCart(BuildContext context);
  Future<UpdateCartModel> updateCart(
      BuildContext context, int quantity, int id);
  Future addToCart(BuildContext context, ProductModel productModel);    
  Future delOrder(BuildContext context, orderID);
  Future<StreamedResponse> makeOrder(BuildContext context, Map<String, String> orderModel, dynamic path);

}
