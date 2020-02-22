import 'package:bots/core/api_utils.dart';
import 'package:bots/core/utils.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:bots/presentation/state/auth_store.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isObsecure = true;
  TextEditingController phoneCtrler = TextEditingController();
  TextEditingController passwordCtrler = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    if(APIs.token != null) Navigator.pop(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              FlutterLogo(
                size: 200,
              ),
              buildUsernameTF(),
              buildPasswordTF(),
              Txt(
                'نسيت كلمة المرور؟',
                style: TxtStyle()
                  ..fontFamily('Cairo')
                  ..alignment.centerRight()
                  ..margin(horizontal: 20)
                  ..bold(),
              ),
              logInBtn(),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Txt(
                    'إنشاء حساب',
                    style: TxtStyle()
                      ..fontFamily('Cairo')
                      ..textColor(ColorsD.main)
                      ..alignment.center()
                      ..bold(),
                    gesture: Gestures()
                      ..onTap(() =>
                          Router.navigator.pushNamed(Router.createAccount)),
                  ),
                  SizedBox(width: 5),
                  Txt(
                    'ليس لديك حساب؟',
                    style: TxtStyle()
                      ..fontFamily('Cairo')
                      ..alignment.center()
                      ..bold(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logInBtn() {
    Size size = MediaQuery.of(context).size;
    Widget onErrorChild = Txt(
      'من فضلك أعد المحاولة',
      style: StylesD.txtOnCardStyle.clone()
        ..background.color(Colors.redAccent)
        ..height(size.height / 18),
      gesture: Gestures()..onTap(() => login()),
    );
    Widget onWaitingChild = Parent(
      child: WaitingWidget(),
      style: StylesD.btnOnCardStyle,
    );
    Widget onIdleChild = Txt(
      'تسجيل الدخول',
      style: StylesD.txtOnCardStyle.clone()..height(size.height / 18),
      gesture: Gestures()..onTap(() => login()),
    );
    return StateBuilder(
      models: [Injector.getAsReactive<AuthStore>()],
      builder: (context, reactiveModel) => reactiveModel.whenConnectionState(
        onIdle: () => onIdleChild,
        onWaiting: () => onWaitingChild,
        onError: (e) => onErrorChild,
        onData: (data) {
          return onIdleChild;
        },
      ),
    );
  }

  Widget buildUsernameTF() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: phoneCtrler,
        validator: (s) {
          if (s == null || s.isEmpty) return "هذا الحقل مطلوب";
        },
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          // prefixText: '+966 |',
          hintText: 'رقم الجوال',
          hintStyle: TextStyle(fontFamily: 'Cairo'),
          prefixIcon: Container(
            width: 50,
            child: Row(
              children: <Widget>[
                Text('+966  '),
                Container(
                  color: ColorsD.main,
                  height: 30,
                  width: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final reactiveModel = Injector.getAsReactive<AuthStore>();
  login() async {
    if (!formKey.currentState.validate()) {
      AlertDialogs.failed(context, content: 'من فضلك أكمل البيانات');

      return;
    }
    await reactiveModel.setState(
        (state) => state.login(context, phoneCtrler.text, passwordCtrler.text));
  }

  Widget buildPasswordTF() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: isObsecure,
        controller: passwordCtrler,
        validator: (s) {
          if (s == null || s.length < 4) return "كلمة المرور قصيرة";
        },
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          // prefixText: '+966 |',
          hintText: 'كلمة المرور',
          hintStyle: TextStyle(fontFamily: 'Cairo'),
          prefixIcon: IconButton(
            onPressed: () {
              isObsecure = !isObsecure;
              setState(() {});
            },
            icon: Icon(Icons.lock),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
