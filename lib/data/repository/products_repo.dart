import 'package:bots/core/api_utils.dart';
import 'package:bots/data/models/all_services.dart';
import 'package:bots/data/models/offers_model.dart';
import 'package:bots/domain/repo/products_repo_inter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ProductsRepo implements IProductsRepo {
  @override
  Future<OffersModel> getAllOffers(context) async {
    // TODO: implement getAllOffers
    String url = APIs.getoffersEP;
    final response = await APIs.getRequest(context, url);
    if (response != null)
      return OffersModel.fromJson(response);
    else
      throw Exception('لا توجد عروض');
  }

  @override
  Future<AllServicesModel> getAllServices(BuildContext context) async {
    // final response = await
    String url = APIs.allServicesEP;

    final response = await APIs.getRequest(context, url);
    if (response != null)
      return AllServicesModel.fromJson(response);
    else
      throw Exception('لا توجد خدمات متاحة');
  }
}
