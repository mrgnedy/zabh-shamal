import 'package:bots/core/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../router.gr.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Txt(
          'طلباتي',
          style: style,
          gesture: Gestures()..onTap(()=>Router.navigator.pushNamed(Router.orders)),
        ),
        Txt('من نحن', style: style),
        Txt('مشاركة التطبيق', style: style),
        Txt('الشروط و الأحكام', style: style),
        Txt('تواصل معنا', style: style),
        Txt('تسجيل الخروج', style: style),
      ],
    );
  }
}
