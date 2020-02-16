import 'package:bots/core/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIs {
  static String baseUrl = 'http://zabayehalshamal.com/api/';
  static String imageBaseUrl =
      'http://zabayehalshamal.com/public/dash/assets/img/';

  static final String bankInfoEP = '${baseUrl}banks';
  static final String allServicesEP = '${baseUrl}services';
  static final String getoffersEP = '${baseUrl}offers';
  static final String getCartEP = '${baseUrl}cart';
  static final String updateCartEP = '${baseUrl}update';
  static final String loginEP = '${baseUrl}login';
  static final String registerEP = '${baseUrl}register';
  static final String contactUsEP = '${baseUrl}contact';
  static final String myOrdersEP = '${baseUrl}myorders';
  static final String deleteOrderEP = '${baseUrl}delorderproduct';
  static final String settingsInfoEP = '${baseUrl}settinginfo';
  static Future getRequest(BuildContext context, url,
      {String token = ''}) async {
    try {

    final response = await http.get(url, headers: {
      'Authorization':
          'Bearer 3zjfkd6G8IOLRwKPx7WVUkFIwXIsPtsjLYmNrew6V5kWkWTilB6uJCnLA6ou1zjFyCS1QLQNA0xnfn1KpwSZK1tpwDDCOJOUlcy2'
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
    } catch (e) {}
  }

  static Future postRequest(
      BuildContext context, String url, Map<String, dynamic> body) async {
    
    try {} catch (e) {}

    final response = await http.post(url, body: body, headers: {
      'Authorization':
          'Bearer 3zjfkd6G8IOLRwKPx7WVUkFIwXIsPtsjLYmNrew6V5kWkWTilB6uJCnLA6ou1zjFyCS1QLQNA0xnfn1KpwSZK1tpwDDCOJOUlcy2'
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
