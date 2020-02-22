import 'package:bots/core/utils.dart';
import 'package:bots/presentation/state/auth_store.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:states_rebuilder/states_rebuilder.dart';

class APIs {
  static String baseUrl = 'http://zabayehalshamal.com/api/';
  static String imageBaseUrl =
      'http://zabayehalshamal.com/public/dash/assets/img/';
  static String token;
  static final String bankInfoEP = '${baseUrl}banks';
  static final String allServicesEP = '${baseUrl}services';
  static final String packNShredEP = '${baseUrl}allservices';
  static final String getoffersEP = '${baseUrl}offers';
  static final String getCartEP = '${baseUrl}cart';
  static final String updateCartEP = '${baseUrl}update';
  static final String loginEP = '${baseUrl}login';
  static final String registerEP = '${baseUrl}register';
  static final String contactUsEP = '${baseUrl}contact';
  static final String myOrdersEP = '${baseUrl}myorders';
  static final String deleteOrderEP = '${baseUrl}delorderproduct';
  static final String delOrderEP = '${baseUrl}uporder';
  static final String addOrderEP = '${baseUrl}addorder';
  static final String addToCartEP = '${baseUrl}addcart';
  static final String settingsInfoEP = '${baseUrl}settinginfo';
  static Future getRequest(BuildContext context, url,
      {String token = ''}) async {
        final reactiveModel = Injector.getAsReactive<AuthStore>();
        String _token;
          if(reactiveModel.state.logInModel!=null)_token=reactiveModel.state.logInModel.apiToken;
    try {

    final response = await http.get(url, headers: {
      'Authorization':
          'Bearer $_token'
    });
    print('token: $_token');
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      final responseData = json.decode(response.body);

      print(responseData);
      if (responseData['msg'].toString().toLowerCase() == 'success')
        return responseData;
      else {
        if (responseData['msg'].toString().contains('unauth'))
          AlertDialogs.failed(context, content: 'يرجى تسجيل الدخول أولا')
              .then((_) {});
        else
          AlertDialogs.failed(context,
              content: responseData['msg'] ??
                  responseData['message'] ??
                  'تعذر الإتصال');
      }
    } else
      AlertDialogs.failed(context, content: 'تعذر الإتصال');
    } catch (e) {}
  }

  static Future postRequest(
      BuildContext context, String url, Map<String, dynamic> body) async {
        final reactiveModel = Injector.getAsReactive<AuthStore>();
        String _token = reactiveModel.state.logInModel?.apiToken;
    
    try {} catch (e) {}

    final response = await http.post(url, body: body, headers: {
      'Authorization':
          'Bearer $_token'
    });
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      final responseData = json.decode(response.body);

      print(responseData);
      if (responseData['msg'].toString().toLowerCase() == 'success')
        return responseData;
      else {
        if (responseData['msg'].toString().contains('unauth'))
          AlertDialogs.failed(context, content: 'يرجى تسجيل الدخول أولا')
              .then((_) {});
        else
          AlertDialogs.failed(context,
              content: responseData['msg'] ??
                  responseData['message'] ??
                  'تعذر الإتصال');
      }
    } else
      AlertDialogs.failed(context, content: 'تعذر الإتصال');
  }
}
