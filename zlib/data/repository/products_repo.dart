import 'package:bots/core/api_utils.dart';
import 'package:bots/data/models/all_services.dart';
import 'package:bots/data/models/cities_model.dart';
import 'package:bots/data/models/offers_model.dart';
import 'package:bots/data/models/pack_shred_model.dart';
import 'package:bots/domain/repo/products_repo_inter.dart';
import 'package:flutter/material.dart';

class ProductsRepo implements IProductsRepo {
  @override
  Future<OffersModel> getAllOffers(context) async {
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

  @override
  Future<PackNShredModel> getAllPackages() async {
    BuildContext context;
    String url = APIs.packNShredEP;
    final response = await APIs.getRequest(context, url);
    if(response != null) return PackNShredModel.fromJson(response);
    throw Exception();
    
  }

  @override
  Future<CititesModel> getAllCities(BuildContext context) async{
    String url = APIs.cities;
    final response = await APIs.getRequest(context, url);
    if(response != null) return CititesModel.fromJson(response);
    throw Exception();
  }
}
