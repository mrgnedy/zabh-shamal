// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:bots/presentation/pages/mainPage.dart';
import 'package:bots/presentation/pages/home/all_products.dart';
import 'package:bots/presentation/pages/cart/cart.dart';
import 'package:bots/presentation/pages/auth/auth_page.dart';
import 'package:bots/presentation/pages/auth/create_account.dart';
import 'package:bots/presentation/pages/home/product.dart';
import 'package:bots/presentation/pages/cart/complete_order.dart';
import 'package:bots/presentation/pages/contacts/contacts.dart';
import 'package:bots/presentation/pages/account/orders.dart';
import 'package:bots/presentation/pages/auth/map.dart';

class Router {
  static const mainPage = '/main-page';
  static const allProducts = '/all-products';
  static const cart = '/cart';
  static const authPage = '/auth-page';
  static const createAccount = '/create-account';
  static const productPage = '/product-page';
  static const orderPage = '/';
  static const contactsPage = '/contacts-page';
  static const orders = '/orders';
  static const map = '/map';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.mainPage:
        return PageRouteBuilder(
          pageBuilder: (ctx, animation, secondaryAnimation) => MainPage(),
          settings: settings,
        );
      case Router.allProducts:
        if (hasInvalidArgs<String>(args)) {
          return misTypedArgsRoute<String>(args);
        }
        final typedArgs = args as String ?? 'h';
        return CupertinoPageRoute(
          builder: (_) => AllProducts(title: typedArgs),
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
        return MaterialPageRoute(
          builder: (_) => ProductPage(),
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
          builder: (_) => Orders(),
          settings: settings,
        );
      case Router.map:
        if (hasInvalidArgs<Function>(args)) {
          return misTypedArgsRoute<Function>(args);
        }
        final typedArgs = args as Function;
        return MaterialPageRoute(
          builder: (_) => Map(typedArgs),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
