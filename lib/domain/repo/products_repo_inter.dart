import 'package:bots/data/models/all_services.dart';
import 'package:bots/data/models/offers_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class IProductsRepo {
  
  Future<AllServicesModel> getAllServices(BuildContext context);
  Future<OffersModel> getAllOffers(BuildContext context);
}