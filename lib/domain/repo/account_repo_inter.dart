import 'package:flutter/material.dart';

abstract class IAccountRepo{
  Future getMyOrders(BuildContext context);
  Future deleteOrder(BuildContext context, orderID);
  Future getInfo(BuildContext context);
  Future contactUs(BuildContext context, String name, String message);
  Future getBankInfo(BuildContext context);
}