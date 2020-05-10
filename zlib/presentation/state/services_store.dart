import 'package:bots/data/models/all_services.dart';
import 'package:bots/data/models/cities_model.dart';
import 'package:bots/data/models/offers_model.dart';
import 'package:bots/data/models/pack_shred_model.dart';
import 'package:bots/domain/repo/products_repo_inter.dart';
import 'package:flutter/material.dart';

class AllServicesStore {
  final IProductsRepo productsRepo;
  AllServicesModel allServicesModel;
  OffersModel offersModel;
  PackNShredModel packNShredModel;
  CititesModel cititesModel;
  List<Services> packages;
  List<Services> shreds;
  List<Services> services;
  AllServicesStore(this.productsRepo) {
    getAllPackages().then((data) {
      shreds = data.data.shudders;
      packages = data.data.packages;
      services = data.data.services;
    });
  }
  Future<AllServicesModel> getAllServices(BuildContext context) async {
    allServicesModel = await productsRepo.getAllServices(context);
    return allServicesModel;
  }

  Future<OffersModel> getOffers(BuildContext context) async {
    offersModel = await productsRepo.getAllOffers(context);
    return offersModel;
  }

  Future<PackNShredModel> getAllPackages() async {
    packNShredModel = await productsRepo.getAllPackages();
    return packNShredModel;
  }

  Future<CititesModel> getAllCities(BuildContext context) async {
    cititesModel = await productsRepo.getAllCities(context);
    return cititesModel;
  }
}
