import 'package:bots/core/api_utils.dart';
import 'package:bots/data/models/cart_model.dart';
import 'package:bots/data/models/offers_model.dart';
import 'package:bots/data/models/update_model.dart';
import 'package:bots/domain/repo/order_repo_inter.dart';
import 'package:http/http.dart';

class CartRepo implements IOrderRepo {
  @override
  Future<CartModel> getCart(context) async {
    // TODO: implement getCart
    final response = await APIs.getRequest(context, APIs.getCartEP);
    if (response != null) {
      return CartModel.fromJson(response);
    } else
      throw Exception();
  }

  @override
  Future makeOrder(context) async {}

  @override
  Future<UpdateCartModel> updateCart(context, quantity, id) async {
    String url = APIs.updateCartEP;
    final response = await APIs.getRequest(context, url);
    if (response != null) {
      return UpdateCartModel.fromJson(response);
    } else
      throw Exception();
  }
}
