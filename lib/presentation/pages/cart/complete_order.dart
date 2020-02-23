import 'dart:convert';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:bots/presentation/state/auth_store.dart';
import 'package:bots/presentation/state/cart_store.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../core/utils.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController countryCode = TextEditingController(text: '+966');
  int paymentMethod = 0;
  @override
  void initState() {
    // TODO: implement initState
    final reactiveModel = Injector.getAsReactive<AuthStore>();
    phoneCtrler.text = reactiveModel.state.logInModel.data.phone;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('إتمام الطلب'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // padding: EdgeInsets.all(10),
            children: <Widget>[
              buildPhone(),
              SizedBox(height: 30),
              buildAddress(),
              SizedBox(height: 30),
              buildPaymentMethod(),
              SizedBox(height: 30),
              paymentMethod == 0 ? Container() : setImage(),
              SizedBox(height: 30),
              completeOrderBtn()
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController phoneCtrler = TextEditingController();
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
            keyboardType: TextInputType.number,
            controller: phoneCtrler,
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
        SizedBox(
          width: 10,
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
  List<Address> address;
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
            maxLines: 3,
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
                .then((perm) async {
              if (perm == PermissionStatus.disabled)
                AppSettings.openLocationSettings();
              
              Router.navigator
                  .pushNamed(Router.map, arguments: setPostion)
                  .then((s) async {
                _position = s;
                address = await Geocoder.local.findAddressesFromCoordinates(
                    Coordinates(_position.latitude, _position.longitude));
                addressCtrler.text = '${address.first.addressLine}';
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
    // _position = pos;
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

  File _image;
  Future<File> pickImage() async {
    return await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
  }

  Widget setImage() {
    return Expanded(
      child: DottedBorder(
        child: GestureDetector(
            onTap: () async {
              _image = await pickImage();
              setState(() {});
            },
            child: _image != null
                ? Image.file(_image, fit: BoxFit.cover)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Icon(
                        Icons.camera_enhance,
                        size: 32,
                      )),
                      Txt('Add Image')
                    ],
                  )),
        radius: Radius.circular(12),
        strokeWidth: 3,
        dashPattern: [6, 6],
        color: Colors.grey,
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
      ),
    );
  }

  completeOrder() {
    if ((_image == null && paymentMethod==1)||
        phoneCtrler.text.isEmpty ||
        addressCtrler.text.isEmpty) {
      AlertDialogs.failed(context, content: 'من فضلك أكمل البيانات');
      return;
    }

    final reactiveModel = Injector.getAsReactive<CartStore>();
    reactiveModel.setState((state) => state.makeOrder(
        context,
        <String, String>{
          "address": address.first.addressLine,
          "lat": address.first.coordinates.latitude.toString(),
          "lng": address.first.coordinates.longitude.toString(),
          "city": address.first.adminArea,
          "name": Injector.get<AuthStore>().logInModel.data.name,
          "phone": phoneCtrler.text,
          "payment_type": paymentMethod.toString(),
          "products": json.encode({"products": (state.cartModel.data)}),
          // "image" : MultipartFile.fromString(_image.readAsStringSync(), 'image.png')
        },
        paymentMethod == 1 ? _image.path : null).then((data){
          if(data != null) AlertDialogs.success(context, content: 'تم اضافة طلبك بنجاح');
        }));
  }

  Widget completeOrderBtn() {
    Widget onIdleWidget = Txt('إتمام الطلب',
        style: StylesD.txtOnCardStyle,
        gesture: Gestures()..onTap(() => completeOrder()));
    Widget onErrorWidget = Txt('إتمام الطلب',
        style: StylesD.txtOnCardStyle.clone()..background.color(Colors.red),
        gesture: Gestures()..onTap(() => completeOrder()));
    Widget onWaitingWidget = Parent(
      child: WaitingWidget(),
    );
    return StateBuilder<CartStore>(
        models: [Injector.getAsReactive<CartStore>()],
        builder: (context, reactiveModel) => reactiveModel.whenConnectionState(
              onIdle: () => onIdleWidget,
              onWaiting: () => onWaitingWidget,
              onError: (e) {
                print(e);
                return onErrorWidget;
              },
              onData: (_) => onIdleWidget,
            ));
  }
}
