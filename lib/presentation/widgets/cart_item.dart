import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/data/models/cart_model.dart';
import 'package:bots/presentation/state/cart_store.dart';
import 'package:bots/presentation/widgets/counter_bar.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class CartItem extends StatefulWidget {
  final Data cartItem;
  final int index;
  CartItem(this.cartItem, this.index);
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Parent(
      style: StylesD.cartStyle.clone()..height(size.height / 4),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Icon(
              FontAwesomeIcons.trashAlt,
              color: Colors.red,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: CounterBar(widget.index),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    defaultRichTxt('النوع', '${widget.cartItem.sername}'),
                    // SizedBox(height: 10),
                    defaultRichTxt('التقطيع', '${widget.cartItem.shudder}'),
                    // SizedBox(height: 10),
                    Container(
                      width: size.width / 2,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          defaultRichTxt('مفروم', 'لا'),
                          defaultRichTxt(
                              'التجهيز', '${widget.cartItem.package}'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                      color: ColorsD.main,
                      height: size.height / 7.9,
                      width: size.width / 4,
                      child: Image.network(
                        '${APIs.imageBaseUrl}${widget.cartItem.product.first.image}',
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                defaultRichTxt('السعر', '${widget.cartItem.totalPrice}'),
                SizedBox(width: 10),
                editQuantityBtn()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget defaultRichTxt(String key, String value) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '$key: ',
          style: TextStyle(color: ColorsD.main, fontFamily: 'Cairo')),
      TextSpan(
          text: '$value',
          style: TextStyle(color: Colors.black, fontFamily: 'Cairo')),
    ]));
  }

  editQuantitiy() {
    final reactiveModel = Injector.getAsReactive<CartStore>();
    reactiveModel.setState((state) => state
        .updateCart(
            context, state.cartCounters[widget.index], widget.cartItem.id)
        .then((_) => state.getCart(context)));
  }

  editQuantityBtn() {
    TxtStyle txtStyle = TxtStyle()
      ..background.color(ColorsD.main)
      ..width(StylesD.size.width / 4)
      ..height(StylesD.size.height / 20)
      ..borderRadius(all: 16)
      ..alignmentContent.center()
      ..textColor(Colors.white);
    final Widget onIdleWidget = Txt(
      'تعديل',
      style: txtStyle,
      // style: StylesD.txtOnCardStyle.clone()..width(StylesD.size.width / 4),
      gesture: Gestures()..onTap(() => editQuantitiy()),
    );
    final Widget onWaiting = Parent(
      child: WaitingWidget(),
      style: StylesD.btnOnCardStyle.clone()..width(StylesD.size.width / 4),
      gesture: Gestures()..onTap(() => editQuantitiy()),
    );
    final Widget onError = Txt(
      'تعديل',
      style: StylesD.txtOnCardStyle.clone()
        ..width(StylesD.size.width / 4)
        ..background.color(Colors.red),
      gesture: Gestures()..onTap(() => editQuantitiy()),
    );
    return StateBuilder<CartStore>(
      models: [Injector.getAsReactive<CartStore>()],
      builder: (context, reactiveModel) {
        return reactiveModel.whenConnectionState(
          onIdle: () => onIdleWidget,
          onWaiting: () => onWaiting,
          onError: (e) => onError,
          onData: (_) => onIdleWidget,
        );
      },
    );
  }
}
