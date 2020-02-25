import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/data/models/all_services.dart';
import 'package:bots/data/models/offers_model.dart';
import 'package:bots/presentation/router.gr.dart';
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
    final reactiveModel = Injector.getAsReactive<AllServicesStore>();
    reactiveModel.setState((state) => state.getOffers(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عروض و منتجات'),
        centerTitle: true,
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
      gesture: Gestures()
        ..onTap(() => Router.navigator.pushNamed(Router.productPage,
            arguments: Product.fromJson(data.toJson()))),
      style: StylesD.cartStyle,
      child: Stack(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            child: Align(
              alignment: AlignmentDirectional(-1, -2.2),
              child: CustomPaint(
                // child: Txt('text', style: TxtStyle()),
                painter: PriceTag(),
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            child: Align(
              alignment: AlignmentDirectional(0, -3.2),
              child: Txt('OFF', style: TxtStyle()..textColor(Colors.yellow)),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            child: Align(
              alignment: AlignmentDirectional(0, -5),
              child: Txt(
                  '${(((data.price - data.priceAfteroffer) / data.price) * 100).round()}%',
                  style: TxtStyle()..textColor(Colors.yellow)),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Txt('${data.name}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Txt('${data.price}ر.س',
                              style: TxtStyle()
                                ..textDirection(TextDirection.rtl)
                                ..textColor(Colors.grey)
                                ..textDecoration(TextDecoration.lineThrough)),
                          Txt('   ر.س '),
                          Txt('${data.priceAfteroffer}'),
                        ],
                      ),
                      Txt('${data.desc}'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${APIs.imageBaseUrl}${data.image}',
                        fit: BoxFit.cover,
                        height: size.height / 7.9,
                        width: size.width / 4,
                      )),
                ),
              ],
            ),
          ),
          Align(),
        ],
      ),
    );
  }
}

class PriceTag extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, 50)
      ..lineTo(25, 35)
      ..lineTo(50, 50)
      ..lineTo(50, 0)
      ..lineTo(0, 0)
      ..moveTo(50, 0);

    path.close();
    paint.style = PaintingStyle.fill;
    paint.color = Colors.red[600];
    canvas.drawShadow(path, ColorsD.elevationColor, 5, true);
    canvas.drawPath(path, paint);
    Path path2 = Path()
      ..moveTo(50, 0)
      ..lineTo(57, 10)
      ..lineTo(50, 10);
    paint.color = Colors.red[900];
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
