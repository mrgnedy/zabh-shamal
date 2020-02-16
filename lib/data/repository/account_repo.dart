import 'package:bots/core/api_utils.dart';
import 'package:bots/data/models/banks_model.dart';
import 'package:bots/domain/repo/account_repo_inter.dart';
import 'package:flutter/material.dart';

class AccountRepo implements IAccountRepo {
  @override
  Future contactUs() {
    // TODO: implement contactUs
    return null;
  }

  @override
  Future deleteOrder() {
    // TODO: implement deleteOrder
    return null;
  }

  @override
  Future getAbout() {
    // TODO: implement getAbout
    return null;
  }

  @override
  Future<BanksModel> getBankInfo(BuildContext context) async {
    // TODO: implement getBankInfo
    final String url = APIs.bankInfoEP;
    final response = await APIs.getRequest(context, url);
    if (response != null)
      return BanksModel.fromJson(response);
    else
      throw Exception();
  }

  @override
  Future getMyOrders() {
    // TODO: implement getMyOrders
    return null;
  }
}
