import 'package:bots/core/utils.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:bots/presentation/state/services_store.dart';
import 'package:bots/presentation/widgets/error_widget.dart';
import 'package:bots/presentation/widgets/idle_widget.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SelectCity extends StatefulWidget {
  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  List<String> dummyValues = [
    'سبيبssسي',
    'سبيبaaسي',
    'سبيبسيaa',
    'سبيبسsdي',
  ];
  String currentCity;
  @override
  void initState() {

    final reactiveModel = Injector.getAsReactive<AllServicesStore>();
    reactiveModel.setState((state) => state.getAllCities(context));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesD.size  = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              logoWidget(),
              selectCityWidget(),
              navigateWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoWidget() {
    return Align(
      alignment: Alignment(0, -0.65),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            Assets.logoKharoof,
            fit: BoxFit.cover,
            height: 200,
          ),
          Txt(
            'ذبائح الشمال',
            style: TxtStyle().clone()
              ..bold()
              ..fontSize(24),
          )
        ],
      ),
    );
  }

  Widget onDataWidget() {
    return Align(
      alignment: Alignment(0, 0.2),
      child: Parent(
        style: ParentStyle()
          ..border(all: 3, color: ColorsD.main)
          ..borderRadius(all: 10)
          ..width(MediaQuery.of(context).size.width*0.75)
          ..padding(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Txt('اختر المدينة'),
            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButton(
                isExpanded: true,
                style: TextStyle(fontFamily: 'Cairo', color: Colors.black),
                hint: Txt('${dummyValues.first}'),
                value: currentCity,
                onChanged: (s) {
                  currentCity = s;
                  setState(() {});
                },
                items: List.generate(
                  dummyValues.length,
                  (index) {
                    return DropdownMenuItem(
                      child: Txt('${dummyValues[index]}'),
                      value: dummyValues[index],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectCityWidget() {
    return StateBuilder<AllServicesStore>(
      models: [Injector.getAsReactive<AllServicesStore>()],
      builder: (context, reactiveModel) => reactiveModel.whenConnectionState(
        onIdle: () => IdleWidget(),
        onWaiting: () => WaitingWidget(),
        onError: (e) => OnErrorWidget('لا توجد مدن'),
        onData: (data) {
          dummyValues = List.generate(data.cititesModel.data.length, (index) {
            final currentValue = data.cititesModel.data[index];
            return currentValue.city;
          });
          // currentCity = dummyValues.first;
          print('$currentCity ss');
          return onDataWidget();
        },
      ),
    );
  }

  TxtStyle txtOnCardStyle = TxtStyle()
    ..fontFamily('Cairo')
    ..textColor(Colors.white)
    ..alignment.center()
    ..alignmentContent.center()
    ..borderRadius(all: 8)
    ..height(50)
    ..background.color(ColorsD.main)
    ..elevation(10, color: ColorsD.elevationColor)
    ..margin(horizontal: 20, bottom: 10);
  Widget navigateWidget() {
    return Txt(
      'متابعة',
      style: txtOnCardStyle.clone()..alignment.bottomCenter(),
      gesture: Gestures()
        ..onTap(() => Router.navigator.pushReplacementNamed(Router.mainPage)),
    );
  }
}
