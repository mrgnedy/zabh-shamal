
import 'package:bots/core/api_utils.dart';
import 'package:bots/data/models/banks_model.dart';
import 'package:bots/data/models/info_model.dart';
import 'package:bots/data/models/my_orders_model.dart';
import 'package:bots/domain/repo/account_repo_inter.dart';
import 'package:flutter/material.dart';

class AccountRepo implements IAccountRepo {
  @override
  Future contactUs(BuildContext context, String name, String message) async {
    String url = APIs.contactUsEP;
    Map<String, dynamic> body = {
      "name": name,
      "message": message,
    };
    final response = await APIs.postRequest(context, url, body);
    if (response != null) return InfoModel.fromJson(response);

    throw Exception();
  }

  @override
  Future deleteOrder(BuildContext context, orderID) async{
    String url = APIs.delOrderEP;
    Map<String, dynamic> body = {'order_id': orderID.toString()};
    final response = await APIs.postRequest(context, url, body);
    if(response != null) return response;
    throw Exception();
    
  }

  @override
  Future<InfoModel> getInfo(BuildContext context) async {
    String url = APIs.settingsInfoEP;
    final response = await APIs.getRequest(context, url);
    if (response != null) return InfoModel.fromJson(response);

    throw Exception();
  }

  @override
  Future<BanksModel> getBankInfo(BuildContext context) async {
    final String url = APIs.bankInfoEP;
    final response = await APIs.getRequest(context, url);
    if (response != null)
      return BanksModel.fromJson(response);
    else
      throw Exception();
  }

  @override
  Future<MyOrdersModel> getMyOrders(BuildContext context) async {
    final String url = APIs.myOrdersEP;
    final response = await APIs.getRequest(context, url);
    if (response != null)
      return MyOrdersModel.fromJson(response);
    else
      throw Exception();
  }
}
