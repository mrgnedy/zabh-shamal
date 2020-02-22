import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/data/models/all_services.dart';
import 'package:bots/data/models/my_orders_model.dart';
import 'package:bots/data/models/pack_shred_model.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:bots/presentation/state/services_store.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class GCartItem extends StatefulWidget {
  final OrderProducts cartItem;

  GCartItem({Key key, this.cartItem}) : super(key: key);

  @override
  _GCartItemState createState() => _GCartItemState();
}

class _GCartItemState extends State<GCartItem> {
  List<Services> services = [];

  List<Services> shreds = [];

  List<Services> packages = [];
  @override
  void initState() {
    final reactiveModel = Injector.getAsReactive<AllServicesStore>();
    services = List.from(reactiveModel.state.services);
    shreds = List.from(reactiveModel.state.shreds);
    packages = List.from(reactiveModel.state.packages);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(()=>Router.navigator.pushNamed(Router.productPage, arguments: Product.fromJson(widget.cartItem.product.toJson()) )),
      style: StylesD.cartStyle.clone()..height(StylesD.size.height / 4),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    defaultRichTxt('النوع',
                        '${services.singleWhere((serv) => serv.id == widget.cartItem.orderService).name}'),
                    // SizedBox(height: 10),
                    defaultRichTxt('التقطيع',
                        '${shreds.singleWhere((shred) => shred.id == widget.cartItem.shudderId).name}'),
                    // SizedBox(height: 10),
                    Container(
                      // width: StylesD.size.width / 2,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          defaultRichTxt('التجهيز',
                              '${packages.singleWhere((pack) => pack.id == widget.cartItem.packageId).name}'),
                        ],
                      ),
                    ),
                    defaultRichTxt('السعر', '${widget.cartItem.price} ر.س'),
                  ],
                ),
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                      color: ColorsD.main,
                      height: StylesD.size.height / 6,
                      width: StylesD.size.width / 3,
                      child: Image.network(
                        '${APIs.imageBaseUrl}${widget.cartItem.product.image}',
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: <Widget>[
          //       defaultRichTxt('السعر', '${cartItem.price}'),
          //       SizedBox(width: 10),
          //     ],
          //   ),
          // )
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
}
