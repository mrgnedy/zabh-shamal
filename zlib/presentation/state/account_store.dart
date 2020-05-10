import 'package:bots/data/models/banks_model.dart';
import 'package:bots/data/models/info_model.dart';
import 'package:bots/data/models/my_orders_model.dart';
import 'package:bots/domain/repo/account_repo_inter.dart';
import 'package:flutter/material.dart';

class AccountStore {
  final IAccountRepo iAccountRepo;
  BanksModel banksModel;
  MyOrdersModel myOrdersModel;
  AccountStore(this.iAccountRepo);
  InfoModel infoModel;
  Future<BanksModel> getBanksInfo(BuildContext context) async {
    banksModel = await iAccountRepo.getBankInfo(context);
    return banksModel;
  }
  Future<MyOrdersModel> getMyOrders(BuildContext context)async{
    myOrdersModel = await iAccountRepo.getMyOrders(context);
    return myOrdersModel;
  }
  Future<InfoModel> getInfo(BuildContext context) async{
    infoModel = await iAccountRepo.getInfo(context);
    return infoModel;
  }
  Future contactUs(BuildContext context, name, message)async{
    return await iAccountRepo.contactUs(context, name, message);
  }

  Future delOrder(BuildContext context, orderID)async{
    return await iAccountRepo.deleteOrder(context, orderID);
  }
}
