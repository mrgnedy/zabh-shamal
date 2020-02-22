import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/presentation/state/services_store.dart';
import 'package:bots/presentation/widgets/error_widget.dart';
import 'package:bots/presentation/widgets/idle_widget.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../router.gr.dart';

class AllServices extends StatefulWidget {
  @override
  _AllServicesState createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  final reactiveModel = Injector.getAsReactive<AllServicesStore>();
  @override
  void initState() {
    // if(reactiveModel.state.allServicesModel != null) return;
    reactiveModel.setState((s) => s.getAllServices(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateBuilder<AllServicesStore>(
        models: [Injector.getAsReactive<AllServicesStore>()],
        builder: (context, reactiveModel) {
          return reactiveModel.whenConnectionState(
            onIdle: () => IdleWidget(),
            onWaiting: () => WaitingWidget(),
            onError: (e) => OnErrorWidget(e.toString()),
            onData: (data) => _buildServices(data),
          );
        });
  }

  Widget _buildServices(AllServicesStore data) {
    final Size size = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      children: List.generate(
        data.allServicesModel.data.length,
        (index) {
          final service = data.allServicesModel.data[index];

          return Parent(
            style: StylesD.cartStyle.clone()..width(size.height / 2.6),
            gesture: Gestures()
              ..onTap(() {
                Router.navigator.pushNamed(Router.allProducts,
                    arguments: AllProductsArguments(
                        title: service.name, products: service.product));
              }),
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                  Parent(
                    // style: StylesD.cartStyle.clone()
                    //   ..padding(all: 0)
                    //   ..margin(all: 0)
                    //   ..elevation(1, angle: 0.3, color: ColorsD.elevationColor),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        '${APIs.imageBaseUrl}${data.allServicesModel.data[index].image}',
                        height: size.height / 4,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Txt('${data.allServicesModel.data[index].name}')
                ])),
          );
        },
      ),
    );
  }
}
