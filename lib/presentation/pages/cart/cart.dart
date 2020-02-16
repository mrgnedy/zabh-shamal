import 'package:bots/core/utils.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:bots/presentation/state/cart_store.dart';
import 'package:bots/presentation/widgets/cart_item.dart';
import 'package:bots/presentation/widgets/error_widget.dart';
import 'package:bots/presentation/widgets/idle_widget.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState

    final reactiveModel = Injector.getAsReactive<CartStore>();
    reactiveModel.setState((state) => state.getCart(context).then((data) {
          state.cartCounters = List.generate(data.data.length,
              (index) => int.parse(data.data[index].qty.toString()));
        }));
    print(countersList);
    super.initState();
  }

  List<int> countersList = [];

  callback(int counter, index) {
    countersList[index] = counter;
    print(countersList);
  }

  @override
  Widget build(BuildContext context) {
    print(countersList);
    return Scaffold(
      body: StateBuilder<CartStore>(
          models: [
            Injector.getAsReactive<CartStore>(),
          ],
          builder: (context, reactiveModel) {
            return reactiveModel.whenConnectionState(
              onIdle: () => IdleWidget(),
              onWaiting: () => WaitingWidget(),
              onError: (e) => OnErrorWidget('e'),
              onData: (s) {
                int totalPrice = 0;
                s.cartModel.data.forEach((cartItem) {
                  totalPrice += int.parse(cartItem.totalPrice.toString());
                });
                return Parent(
                  child: ListView(
                    shrinkWrap: true,
                    children: List.generate(3, (index) {
                      return CartItem(s.cartModel.data[index], index);
                    })
                      ..addAll(
                        [
                          buildTotalPrice(totalPrice),
                          completeOrderButton(),
                        ],
                      ),
                  ),
                );
              },
            );
          }),
    );
  }

  Widget buildTotalPrice(int totalPrice) {
    return Txt('المجموع: $totalPrice',
        style: StylesD.txtOnCardStyle.clone()
          ..background.color(ColorsD.main.withAlpha(180)));
  }

  Widget completeOrderButton() {
    return Txt(
      'إتمام الطلب',
      gesture: Gestures()
        ..onTap(() {
          SharedPreferences.getInstance().then((pref) {
            if (pref.getString('auth_data') != null)
              Router.navigator.pushNamed(Router.orderPage);
            else
              Router.navigator.pushNamed(Router.authPage);
          });
        }),
      style: StylesD.txtOnCardStyle,
    );
  }

  Widget cartItem() {}
}
