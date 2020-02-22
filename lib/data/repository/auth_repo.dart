

import 'package:bots/core/api_utils.dart';
import 'package:bots/data/models/log_in_model.dart';
import 'package:bots/data/models/register_model.dart';
import 'package:bots/domain/repo/auth_repo_inter.dart';
import 'package:flutter/material.dart';


class AuthRepo implements IAuthRepo {
  @override
  Future<LogInModel> login(
      BuildContext context, String phone, String password) async {
    final url = APIs.loginEP;
    final Map<String, dynamic> body = {
      'phone': '$phone',
      'password': '$password',
    };
    final response = await APIs.postRequest(context, url, body);
    if (response != null) {
      return LogInModel.fromJson(response);
      // pref.setString(json.encode(LogInData., value)
    } else
      throw Exception();
  }

  @override
  Future register(
    BuildContext context,
    String name,
    String phone,
    String password,
    String confirmPassword,
    String email,
  ) async {
    final url = APIs.registerEP;
    final Map<String, dynamic> body = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'confirmpass': confirmPassword,
    };
    final response = await APIs.postRequest(context, url, body);
    if (response != null)
      return RegisterModel.fromJson(response);
    else
      throw Exception();
  }
}
