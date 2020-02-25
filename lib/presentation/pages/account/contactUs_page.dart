import 'package:bots/core/utils.dart';
import 'package:bots/presentation/state/account_store.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final reactiveModel = Injector.getAsReactive<AccountStore>();
  @override
  void initState() {
    // TODO: implement initState
    reactiveModel.state.getInfo(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تواصل معنا'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: name,
                    textAlign: TextAlign.right,
                    decoration: StylesD.inputDecoration,
                  ),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('الإسم'))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: message,
                    textAlign: TextAlign.right,
                    decoration: StylesD.inputDecoration,
                    maxLines: 5,
                  ),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('انرك رسالتك'))),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          sendBtn(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Divider(
                thickness: 2,
              )),
              Padding(padding: EdgeInsets.all(5), child: Text('أو')),
              Expanded(
                  child: Divider(
                thickness: 2,
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildPhone(),
              SizedBox(
                width: 10,
              ),
              buildWhats(),
            ],
          )
        ],
      ),
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController message = TextEditingController();
  sendWhatever() {
    final reactiveModel = Injector.getAsReactive<AccountStore>();
    reactiveModel
        .setState((state) => state.contactUs(context, name.text, message.text));
  }

  Widget sendBtn() {
    Widget onIdleWidget = Txt('إرسال',
        style: StylesD.txtOnCardStyle,
        gesture: Gestures()..onTap(() => sendWhatever()));
    Widget onErrorWidget = Txt('إرسال',
        style: StylesD.txtOnCardStyle.clone()..background.color(Colors.red),
        gesture: Gestures()..onTap(() => sendWhatever()));
    return StateBuilder<AccountStore>(
      models: [Injector.getAsReactive<AccountStore>()],
      builder: (context, reactiveModel) => reactiveModel.whenConnectionState(
        onIdle: () => onIdleWidget,
        onWaiting: () => WaitingWidget(),
        onError: (e) => onErrorWidget,
        onData: (data) {
          return onIdleWidget;
        },
      ),
    );
  }

  Widget buildPhone() {
    String phoneNumber = "tel:${reactiveModel.state.infoModel.data.phone}";
    return GestureDetector(
      onTap: () => phoneCall(phoneNumber),
      child: Icon(
        Icons.phone,
        size: 32,
        color: Colors.cyan,
      ),
    );
  }

  Widget buildWhats() {
    String whatsNumber =
        "https://api.whatsapp.com/send?phone=${reactiveModel.state.infoModel.data.whatsapp}&text=${'السلام عليكم'}";
    return GestureDetector(
      onTap: () => phoneCall(whatsNumber),
      child: Icon(
        FontAwesomeIcons.whatsapp,
        size: 32,
        color: Colors.green,
      ),
    );
  }

  phoneCall(String phone) async {
    if (await canLaunch('$phone')) await launch('$phone');
  }
}
