import 'package:bots/core/utils.dart';
import 'package:bots/data/repository/account_repo.dart';
import 'package:bots/data/repository/auth_repo.dart';
import 'package:bots/data/repository/cart_repo.dart';
import 'package:bots/data/repository/products_repo.dart';
import 'package:bots/presentation/pages/mainPage.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:bots/presentation/state/account_store.dart';
import 'package:bots/presentation/state/auth_store.dart';
import 'package:bots/presentation/state/cart_store.dart';
import 'package:bots/presentation/state/services_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() {
  // DateTime t= DateTime.now().add(Duration(
  //   minutes:7
  // ));
  // print(t.difference(DateTime.now()).inMinutes > 7);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: [
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate
      // ],
      // supportedLocales: [
      //   Locale('ar')
      // ],

      onGenerateRoute: Router.onGenerateRoute,
      // initialRoute: Router.mainPage,

      navigatorKey: Router.navigatorKey,
      home: Injector(
        builder: (context) {
          StylesD.size = MediaQuery.of(context).size;
          return MainPage();
        },
        inject: [
          Inject<AllServicesStore>(() => AllServicesStore(ProductsRepo())),
          Inject<CartStore>(() => CartStore(CartRepo())),
          Inject<AuthStore>(
            () => AuthStore(AuthRepo()),
            isLazy: false,
          ),
          Inject<AccountStore>(() => AccountStore(AccountRepo()))
        ],
      ),
      theme: ThemeData(
        textTheme: TextTheme(
            body1: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w100)),
        appBarTheme: AppBarTheme(
            color: ColorsD.main,
            textTheme: TextTheme(
              title: TextStyle(fontFamily: 'Cairo', fontSize: 18),
            )),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
