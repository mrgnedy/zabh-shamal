import 'package:app_settings/app_settings.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController countryCode = TextEditingController(text: '+966');
  int paymentMethod = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إتمام الطلب'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            buildPhone(),
            SizedBox(height: 30),
            buildAddress(),
            SizedBox(height: 30),
            buildPaymentMethod(),
            SizedBox(height: 30),
            completeOrder()
          ],
        ),
      ),
    );
  }

  Widget buildPhone() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Txt(
            'رقم الجوال:',
            style: TxtStyle()..fontFamily('Cairo'),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextField(
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsD.main, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsD.main, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextField(
            controller: countryCode,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsD.main, width: 51),
              borderRadius: BorderRadius.circular(8),
            )),
          ),
        ),
      ],
    );
  }

  TextEditingController addressCtrler = TextEditingController();
  Widget buildAddress() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Txt(
            'العنوان:',
            style: TxtStyle()..fontFamily('Cairo'),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextField(
            controller: addressCtrler,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsD.main, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsD.main, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () async {
            PermissionHandler()
                .checkPermissionStatus(PermissionGroup.location)
                .then((perm) {
              if (perm == PermissionStatus.disabled)
                AppSettings.openLocationSettings();

              Router.navigator
                  .pushNamed(Router.map, arguments: setPostion)
                  .then((s) {
                addressCtrler.text = '${_position.longitude}';
                setState(() {});
              });
            });
          },
          child: Icon(
            Icons.location_on,
            color: ColorsD.main,
          ),
        )),
      ],
    );
  }

  Position _position;
  setPostion(pos) {
    _position = pos;
  }

  Widget buildPaymentMethod() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Txt(
            'طريقة الدفع:',
            style: TxtStyle()
              ..fontFamily('Cairo')
              ..padding(top: 12),
          ),
        ),
        Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RadioListTile(
                  value: 0,
                  groupValue: paymentMethod,
                  onChanged: (s) {
                    paymentMethod = s;
                    setState(() {});
                  },
                  activeColor: ColorsD.main,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Txt(
                    'الدفع عند الاستلام',
                    style: TxtStyle()..fontFamily('Cairo'),
                  ),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: paymentMethod,
                  onChanged: (s) {
                    paymentMethod = s;
                    setState(() {});
                  },
                  activeColor: ColorsD.main,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Txt(
                    'تحويل بنكي',
                    style: TxtStyle()..fontFamily('Cairo'),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget completeOrder() {
    return Txt('إتمام الطلب',
        style: TxtStyle()
          ..fontFamily('Cairo')
          ..textColor(Colors.white)
          ..background.color(ColorsD.main)
          ..margin(all: 10)
          ..height(50)
          ..elevation(10, color: ColorsD.elevationColor)
          ..alignmentContent.center()
          ..borderRadius(all: 8));
  }
}
