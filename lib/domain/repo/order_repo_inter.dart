import 'package:bots/data/models/cart_model.dart';
import 'package:bots/data/models/offers_model.dart';
import 'package:bots/data/models/update_model.dart';
import 'package:flutter/material.dart';

abstract class IOrderRepo {
  Future<CartModel> getCart(BuildContext context);
  Future<UpdateCartModel> updateCart(
      BuildContext context, int quantity, int id);
  Future makeOrder(context);
}
