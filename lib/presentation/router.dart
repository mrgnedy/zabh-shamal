import 'package:auto_route/auto_route_annotations.dart';
import 'package:bots/main.dart';
import 'package:bots/presentation/pages/account/orders.dart';
import 'package:bots/presentation/pages/auth/create_account.dart';
import 'package:bots/presentation/pages/auth/map.dart';
import 'package:bots/presentation/pages/cart/cart.dart';
import 'package:bots/presentation/pages/cart/complete_order.dart';
import 'package:bots/presentation/pages/contacts/contacts.dart';
import 'package:bots/presentation/pages/drawer/offers_new.dart';
import 'package:bots/presentation/pages/home/all_products.dart';
import 'package:bots/presentation/pages/home/product.dart';
import 'package:bots/presentation/pages/mainPage.dart';

import 'pages/auth/auth_page.dart';

@autoRouter
class $Router {
  // MyHomePage myHomePage;
  @CustomRoute(initial: true)
  MainPage mainPage;
  @CupertinoRoute()
  AllProducts allProducts;
  Cart cart;
  AuthPage authPage;
  CreateAccount createAccount;
  ProductPage productPage;
  OrderPage orderPage;
  ContactsPage contactsPage;
  Orders orders;
  Map map;
  OffersPage offersPage;
}
