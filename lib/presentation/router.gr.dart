// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:bots/presentation/pages/mainPage.dart';
import 'package:bots/presentation/pages/home/all_products.dart';
import 'package:bots/data/models/all_services.dart';
import 'package:bots/presentation/pages/cart/cart.dart';
import 'package:bots/presentation/pages/auth/auth_page.dart';
import 'package:bots/presentation/pages/auth/create_account.dart';
import 'package:bots/presentation/pages/home/product.dart';
import 'package:bots/presentation/pages/cart/complete_order.dart';
import 'package:bots/presentation/pages/contacts/contacts.dart';
import 'package:bots/presentation/pages/account/orders.dart';
import 'package:bots/presentation/pages/auth/map.dart';
import 'package:bots/presentation/pages/drawer/offers_new.dart';
import 'package:bots/presentation/pages/account/empty_page.dart';
import 'package:bots/presentation/pages/account/contactUs_page.dart';
import 'package:bots/presentation/pages/account/order_products.dart';
import 'package:bots/data/models/my_orders_model.dart';
import 'package:bots/presentation/pages/drawer/how_shopping.dart';
import 'package:bots/presentation/pages/splash.dart';

class Router {
  static const mainPage = '/main-page';
  static const allProducts = '/all-products';
  static const cart = '/cart';
  static const authPage = '/auth-page';
  static const createAccount = '/create-account';
  static const productPage = '/product-page';
  static const orderPage = '/order-page';
  static const contactsPage = '/contacts-page';
  static const orders = '/orders';
  static const map = '/map';
  static const offersPage = '/offers-page';
  static const emptyPage = '/empty-page';
  static const contactUsPage = '/contact-us-page';
  static const orderProductcsPage = '/order-productcs-page';
  static const howShopping = '/how-shopping';
  static const selectCity = '/';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.mainPage:
        return MaterialPageRoute(
          builder: (_) => MainPage(),
          settings: settings,
        );
      case Router.allProducts:
        if (hasInvalidArgs<AllProductsArguments>(args)) {
          return misTypedArgsRoute<AllProductsArguments>(args);
        }
        final typedArgs =
            args as AllProductsArguments ?? AllProductsArguments();
        return CupertinoPageRoute(
          builder: (_) =>
              AllProducts(title: typedArgs.title, products: typedArgs.products),
          settings: settings,
        );
      case Router.cart:
        return MaterialPageRoute(
          builder: (_) => Cart(),
          settings: settings,
        );
      case Router.authPage:
        return MaterialPageRoute(
          builder: (_) => AuthPage(),
          settings: settings,
        );
      case Router.createAccount:
        return MaterialPageRoute(
          builder: (_) => CreateAccount(),
          settings: settings,
        );
      case Router.productPage:
        if (hasInvalidArgs<Product>(args)) {
          return misTypedArgsRoute<Product>(args);
        }
        final typedArgs = args as Product;
        return MaterialPageRoute(
          builder: (_) => ProductPage(product: typedArgs),
          settings: settings,
        );
      case Router.orderPage:
        return MaterialPageRoute(
          builder: (_) => OrderPage(),
          settings: settings,
        );
      case Router.contactsPage:
        return MaterialPageRoute(
          builder: (_) => ContactsPage(),
          settings: settings,
        );
      case Router.orders:
        return MaterialPageRoute(
          builder: (_) => OrdersPage(),
          settings: settings,
        );
      case Router.map:
        if (hasInvalidArgs<Function>(args)) {
          return misTypedArgsRoute<Function>(args);
        }
        final typedArgs = args as Function;
        return CupertinoPageRoute(
          builder: (_) => Map(typedArgs),
          settings: settings,
          fullscreenDialog: true,
        );
      case Router.offersPage:
        return MaterialPageRoute(
          builder: (_) => OffersPage(),
          settings: settings,
        );
      case Router.emptyPage:
        if (hasInvalidArgs<EmptyPageArguments>(args)) {
          return misTypedArgsRoute<EmptyPageArguments>(args);
        }
        final typedArgs = args as EmptyPageArguments ?? EmptyPageArguments();
        return MaterialPageRoute(
          builder: (_) => EmptyPage(
              key: typedArgs.key,
              title: typedArgs.title,
              content: typedArgs.content),
          settings: settings,
        );
      case Router.contactUsPage:
        return MaterialPageRoute(
          builder: (_) => ContactUsPage(),
          settings: settings,
        );
      case Router.orderProductcsPage:
        if (hasInvalidArgs<OrderProductcsPageArguments>(args)) {
          return misTypedArgsRoute<OrderProductcsPageArguments>(args);
        }
        final typedArgs = args as OrderProductcsPageArguments ??
            OrderProductcsPageArguments();
        return MaterialPageRoute(
          builder: (_) => OrderProductcsPage(
              key: typedArgs.key,
              title: typedArgs.title,
              products: typedArgs.products),
          settings: settings,
        );
      case Router.howShopping:
        if (hasInvalidArgs<HowShoppingArguments>(args)) {
          return misTypedArgsRoute<HowShoppingArguments>(args);
        }
        final typedArgs =
            args as HowShoppingArguments ?? HowShoppingArguments();
        return MaterialPageRoute(
          builder: (_) => HowShopping(
              key: typedArgs.key,
              title: typedArgs.title,
              jsonKey: typedArgs.jsonKey),
          settings: settings,
        );
      case Router.selectCity:
        return MaterialPageRoute(
          builder: (_) => SelectCity(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//AllProducts arguments holder class
class AllProductsArguments {
  final String title;
  final List<Product> products;
  AllProductsArguments({this.title = 'h', this.products});
}

//EmptyPage arguments holder class
class EmptyPageArguments {
  final Key key;
  final String title;
  final String content;
  EmptyPageArguments({this.key, this.title, this.content});
}

//OrderProductcsPage arguments holder class
class OrderProductcsPageArguments {
  final Key key;
  final String title;
  final List<OrderProducts> products;
  OrderProductcsPageArguments({this.key, this.title, this.products});
}

//HowShopping arguments holder class
class HowShoppingArguments {
  final Key key;
  final String title;
  final String jsonKey;
  HowShoppingArguments({this.key, this.title, this.jsonKey});
}
