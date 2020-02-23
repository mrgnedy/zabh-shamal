import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class MainPageDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Drawer(
        elevation: 20,
        child: Stack(
          children: [
            Align(
                alignment:
                    Alignment.lerp(Alignment.center, Alignment.topCenter, 1),
                child: Image.asset(Assets.logo,fit: BoxFit.cover,height: 300,width: 300),),
            Align(
              alignment: Alignment.center,
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

                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: <Widget>[
                    //       Txt(
                    //         'مشاركة التطبيق',
                    //         gesture: Gestures()
                    //           ..onTap(() {
                    //             Share.share('SHARE TEST');
                    //           }),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Icon(Icons.person, color: ColorsD.main),
                    //     ]),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    GestureDetector(
                      onTap: ()=>Router.navigator.pushNamed(Router.howShopping),

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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
