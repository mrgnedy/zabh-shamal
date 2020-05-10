import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/presentation/state/account_store.dart';
import 'package:bots/presentation/widgets/idle_widget.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class HowShopping extends StatefulWidget {
  final String jsonKey;
  final String title;

  const HowShopping({Key key, this.title, this.jsonKey}) : super(key: key);
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
        title: Text('${widget.title}'),
        centerTitle: true,
      ),
      body: buildHowShopping(),
    );
  }

  Widget onDataWidget(String content) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.height,
        width: size.width,
        child: Image.network(
          '${APIs.imageBaseUrl}$content',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget buildHowShopping() {
    return StateBuilder<AccountStore>(
      models: [Injector.getAsReactive<AccountStore>()],
      builder: (context, reactiveModel) => reactiveModel.whenConnectionState(
        onIdle: () => IdleWidget(),
        onWaiting: () => WaitingWidget(),
        onData: (data) =>
            onDataWidget(data.infoModel.data.toJson()['${widget.jsonKey}']),
        onError: null,
      ),
    );
  }
}
