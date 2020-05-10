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
    if (APIs.token != null) Navigator.pop(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Form(
              key: formKey,
              child: Container(
                // alignment: Alignment(0, -0.65),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Image.asset(
                      Assets.logoKharoof,
                      height: 200,
                    ),
                    Txt(
                      'ذبائح الشمال',
                      style: TxtStyle()
                        ..fontWeight(FontWeight.w600)
                        ..textShadow(blur: 10)
                        ..fontSize(32)..alignment.center()
                    ),
                    buildUsernameTF(),
                    buildPasswordTF(),
                    SizedBox(
                      height: 20,
                    ),
                    // Txt(
                    //   'نسيت كلمة المرور؟',
                    //   style: TxtStyle()
                    //     ..fontFamily('Cairo')
                    //     ..alignment.centerRight()
                    //     ..margin(horizontal: 20)
                    //     ..bold(),
                    // ),
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
                            ..onTap(() => Router.navigator
                                .pushNamed(Router.createAccount)),
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
            Parent(
              child: Icon(Icons.arrow_back),
              gesture: Gestures()
                ..onTap(() => [Navigator.pop(context), print('s')]),
              style: ParentStyle()..margin(all: 12),
            ),
          ],
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
      style: StylesD.cartStyle,
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
        keyboardType: TextInputType.number,
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
    await reactiveModel.setState((state) => state
            .login(context, '+966${phoneCtrler.text}', passwordCtrler.text)
            .then((data) {
          AlertDialogs.success(context, content: 'تم تسجيل دخولك بنجاح')
              .then((_) {
            Navigator.pop(context);
          });
        }));
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
