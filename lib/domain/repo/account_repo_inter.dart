import 'package:flutter/material.dart';

abstract class IAccountRepo{
  Future getMyOrders();
  Future deleteOrder();
  Future getAbout();
  Future contactUs();
  Future getBankInfo(BuildContext context);
}