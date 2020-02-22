import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/data/models/info_model.dart';
import 'package:bots/presentation/state/account_store.dart';
import 'package:bots/presentation/state/auth_store.dart';
import 'package:bots/presentation/widgets/error_widget.dart';
import 'package:bots/presentation/widgets/idle_widget.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

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
  void initState() {
    final reactiveModel = Injector.getAsReactive<AccountStore>();
    reactiveModel.setState((state) => state.getInfo(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder<AccountStore>(
        models: [Injector.getAsReactive<AccountStore>()],
        builder: (context, reactiveModel) => reactiveModel.whenConnectionState(
              onIdle: () => IdleWidget(),
              onWaiting: () => WaitingWidget(),
              onError: (e) => OnErrorWidget(e),
              onData: (data) => accountWidget(data.infoModel.data),
            ));
  }

  accountWidget(InfoData infoData) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Txt(
          'طلباتي',
          style: style,
          gesture: Gestures()
            ..onTap(() {
              if(APIs.token != null)
              Router.navigator.pushNamed(Router.orders);
              else AlertDialogs.failed(context, content: "من فضلك سجل الدخول");
            }),
        ),
        Txt(
          'من نحن',
          style: style,
          gesture: Gestures()
            ..onTap(() => Router.navigator.pushNamed(Router.emptyPage,
                arguments: EmptyPageArguments(
                    content: infoData.aboutUs, title: 'من نحن'))),
        ),
        Txt('مشاركة التطبيق',
            style: style,
            gesture: Gestures()
              ..onTap(
                () => Share.share('text'),
              )),
        Txt(
          'الشروط و الأحكام',
          style: style,
          gesture: Gestures()
            ..onTap(() => Router.navigator.pushNamed(Router.emptyPage,
                arguments: EmptyPageArguments(
                    content: infoData.conditions, title: 'الشروط و الأحكام'))),
        ),
        Txt('تواصل معنا',
            style: style,
            gesture: Gestures()
              ..onTap(() => Router.navigator.pushNamed(Router.contactUsPage))),
        buildLogOut()
      ],
    );
  }

  buildLogOut() {
    String authState;
    if (APIs.token != null) {
      authState = "الخروج";
      return Txt('تسجيل $authState',
          style: style,
          gesture: Gestures()
            ..onTap(() async {
              APIs.token = null;
              final reactiveModel = Injector.getAsReactive<AuthStore>();
              reactiveModel.state.logInModel = null;
              final pref = await SharedPreferences.getInstance();
              pref.setString('auth_data', null);
              setState(() {
                authState = 'الدخول';
              });
            }));
    } else {
      authState = 'الدخول';
      return Txt('تسجيل $authState',
          style: style,
          gesture: Gestures()
            ..onTap(() {
              Router.navigator.pushNamed(Router.authPage);
            }));
    }
  }
}
