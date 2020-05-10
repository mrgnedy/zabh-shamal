import 'dart:io';

import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class MainPageDrawer extends StatelessWidget {
  TxtStyle style = TxtStyle()
    ..fontFamily('Cairo')
    ..textColor(ColorsD.main)
    ..elevation(10, color: ColorsD.elevationColor)
    ..background.color(Colors.white)
    ..height(50)
    ..margin(all: 10)
    ..borderRadius(all: 8)
    ..alignment.center()
    ..alignmentContent.center();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Opacity(
        opacity: 0.95,
        child: Drawer(
          elevation: 20,
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, -0.9),
                child: Txt('ذبائح الشمال',
                    style: TxtStyle()
                      ..fontWeight(FontWeight.w600)
                      ..textShadow(blur: 10)
                      ..fontSize(32)),
              ),
              Align(
                alignment:
                    Alignment.lerp(Alignment.center, Alignment.topCenter, 1),
                child: Image.asset(Assets.logo,
                    fit: BoxFit.cover, height: 300, width: 300),
              ),
              Align(
                alignment: Alignment(0,0.37),
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Txt(
                              'الرئيسية',
                              gesture: Gestures()
                                ..onTap(
                                  () => Router.navigator.pushNamedAndRemoveUntil(
                                      Router.mainPage,
                                      (Route<dynamic> route) => false),
                                ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.home,
                              color: ColorsD.main,
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Txt(
                              'عروض و منتجات جديدة',
                              gesture: Gestures()
                                ..onTap(() {
                                  Router.navigator.pushNamed(Router.offersPage);
                                }),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.ac_unit, color: ColorsD.main),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Txt(
                              'مشاركة التطبيق',
                              gesture: Gestures()
                                ..onTap(() {
                                  if (Platform.isIOS)
                                    Share.share(
                                        'http://itunes.apple.com/app/id1500475427');
                                  else
                                    Share.share(
                                      'https://play.google.com/store/apps/details?id=com.skinnyg.bots',
                                    );

                                  // Share.share('SHARE TEST');
                                }),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.person, color: ColorsD.main),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => Router.navigator.pushNamed(
                            Router.howShopping,
                            arguments: HowShoppingArguments(
                                title: 'طريقة الطلب', jsonKey: 'shopping')),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Txt('طريقة الطلب'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.style, color: ColorsD.main),
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Txt(
                            'من نحن',
                            // style: style,
                            gesture: Gestures()
                              ..onTap(() => Router.navigator.pushNamed(
                                  Router.howShopping,
                                  arguments: HowShoppingArguments(
                                      jsonKey: 'about_us', title: 'من نحن'))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.people, color: ColorsD.main),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Txt(
                            'الشروط و الأحكام',
                            // style: style,
                            gesture: Gestures()
                              ..onTap(() => Router.navigator.pushNamed(
                                  Router.howShopping,
                                  arguments: HowShoppingArguments(
                                      jsonKey: 'conditions',
                                      title: 'الشروط و الأحكام'))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.assignment, color: ColorsD.main),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: APIs.token == null,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Txt(
                                'انشاء حساب/تسجيل الدخول',
                                gesture: Gestures()
                                  ..onTap(() => Router.navigator
                                      .pushNamed(Router.authPage)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.share, color: ColorsD.main),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
