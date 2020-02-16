import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/data/models/offers_model.dart';
import 'package:bots/presentation/state/services_store.dart';
import 'package:bots/presentation/widgets/idle_widget.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  void initState() {
    // TODO: implement initState

    final reactiveModel = Injector.getAsReactive<AllServicesStore>();
    reactiveModel.setState((state) => state.getOffers(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عروض و منتجات'),
      ),
      body: StateBuilder<AllServicesStore>(
        models: [Injector.getAsReactive<AllServicesStore>()],
        builder: (context, reactiveModel) {
          return reactiveModel.whenConnectionState(
            onIdle: () => IdleWidget(),
            onWaiting: () => WaitingWidget(),
            onError: (e) => ErrorWidget(e),
            onData: (data) => dataWidget(data.offersModel.data),
          );
        },
      ),
    );
  }

  Widget dataWidget(List<Data> data) {
    return ListView(
      shrinkWrap: true,
      children: List.generate(
        data.length,
        (index) {
          return offerItem(data[index]);
        },
      ),
    );
  }

  Widget offerItem(Data data) {
    Size size = MediaQuery.of(context).size;
    return Parent(
      style: StylesD.cartStyle,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  '${APIs.imageBaseUrl}${data.image}',
                  fit: BoxFit.cover,
                  height: size.height / 7.9,
                  width: size.width / 4,
                )),
          ),
          Align(
            
          ),
        ],
      ),
    );
  }
}
