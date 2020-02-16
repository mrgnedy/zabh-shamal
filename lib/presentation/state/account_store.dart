import 'package:bots/core/api_utils.dart';
import 'package:bots/data/models/banks_model.dart';
import 'package:bots/domain/repo/account_repo_inter.dart';
import 'package:flutter/material.dart';

class AccountStore {
  final IAccountRepo iAccountRepo;
  BanksModel banksModel;
  AccountStore(this.iAccountRepo);

  Future<BanksModel> getBanksInfo(BuildContext context) async {
    banksModel = await iAccountRepo.getBankInfo(context);
    return banksModel;
  }
}
