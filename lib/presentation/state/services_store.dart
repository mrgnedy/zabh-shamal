import 'package:bots/data/models/all_services.dart';
import 'package:bots/data/models/offers_model.dart';
import 'package:bots/domain/repo/products_repo_inter.dart';
import 'package:flutter/material.dart';

class AllServicesStore {
  final IProductsRepo productsRepo;
  AllServicesModel allServicesModel;
  OffersModel offersModel;
  AllServicesStore(this.productsRepo);
  Future<AllServicesModel> getAllServices(BuildContext context) async {
    allServicesModel = await productsRepo.getAllServices(context);
    return allServicesModel;
  }

  Future<OffersModel> getOffers(BuildContext context) async {
    offersModel = await productsRepo.getAllOffers(context);
    return offersModel;
  }
}
