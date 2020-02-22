import 'package:bots/core/utils.dart';
import 'package:bots/presentation/state/account_store.dart';
import 'package:bots/presentation/widgets/idle_widget.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class HowShopping extends StatefulWidget {
  @override
  _HowShoppingState createState() => _HowShoppingState();
}

class _HowShoppingState extends State<HowShopping> {
  @override
  void initState() {
    final reacvtiveModel = Injector.getAsReactive<AccountStore>();
    reacvtiveModel.setState((state) => state.getInfo(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('كيفيةالطلب'),
        centerTitle: true,
      ),
      body: buildHowShopping(),
    );
  }

  Widget onDataWidget(String content) {
    return Center(
      child: ListView(shrinkWrap: true, children: [
        Txt(
          content,
          style: StylesD.txtStyle.clone()
            ..alignment.center()
            ..fontSize(20)
            ..margin(all: 10),
        ),
      ]),
    );
  }

  Widget buildHowShopping() {
    return StateBuilder<AccountStore>(
      models: [Injector.getAsReactive<AccountStore>()],
      builder: (context, reactiveModel) => reactiveModel.whenConnectionState(
        onIdle: () => IdleWidget(),
        onWaiting: () => WaitingWidget(),
        onData: (data) =>
            onDataWidget(data.infoModel.data.toJson()['shopping']),
        onError: null,
      ),
    );
  }
}
