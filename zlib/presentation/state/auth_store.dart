import 'dart:convert';

import 'package:bots/core/api_utils.dart';
import 'package:bots/data/models/log_in_model.dart';
import 'package:bots/data/models/register_model.dart';
import 'package:bots/domain/repo/auth_repo_inter.dart';
import 'package:bots/presentation/state/cart_store.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AuthStore {
  final IAuthRepo iAuthRepo;
  LogInModel logInModel;
  RegisterModel registerModel;
  SharedPreferences pref;

  AuthStore(this.iAuthRepo) {
    print('Auth Store Instantiated');
    SharedPreferences.getInstance().then((p) {
      pref = p;
      if (p.getString('auth_data') != null) {
        logInModel = LogInModel.fromJson(json.decode(p.getString('auth_data')));
        APIs.token = logInModel.apiToken;
        print(APIs.token);
      }
    });
  }

  Future<LogInModel> login(
      BuildContext context, String phone, String password) async {
    logInModel = await iAuthRepo.login(context, phone, password);
    if (logInModel != null) {
      pref.setString('auth_data', json.encode(logInModel.toJson()));
      APIs.token = logInModel.apiToken;
      final reactiveModel = Injector.getAsReactive<CartStore>();
      reactiveModel.state.cartModel = null;
      
      // Navigator.pop(context);
    }
    return logInModel;
  }

  Future<RegisterModel> register(
    BuildContext context,
    String name,
    String phone,
    String password,
    String confirmPassword,
    String email,
  ) async {
    registerModel = await iAuthRepo.register(
      context,
      name,
      phone,
      password,
      confirmPassword,
      email,
    );
    if (registerModel != null) {
      pref.setString('auth_data', json.encode(registerModel.toJson()));
      logInModel = LogInModel.fromJson(registerModel.toJson());
      APIs.token = logInModel.apiToken;
      
    }
    return registerModel;
  }
}
