import 'package:bots/core/utils.dart';
import 'package:bots/presentation/state/auth_store.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../router.gr.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController phoneCtrler = TextEditingController();
  TextEditingController passwordCtrler = TextEditingController();
  TextEditingController nameCtrler = TextEditingController();
  TextEditingController emailCtrler = TextEditingController();
  @override
  void dispose() {
    // nameCtrler.dispose();
    // passwordCtrler.dispose();
    // nameCtrler.dispose();
    // emailCtrler.dispose();
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey();
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
              child: Align(
                alignment: Alignment(0, -0.65),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Align(
                      child: Hero(
                        tag: '5aroof',
                        child: Image.asset(Assets.logoKharoof,
                            height: 200, fit: BoxFit.cover),
                      ),
                    ),
                    Txt(
                      'ذبائح الشمال',
                      style: TxtStyle()
                        ..fontWeight(FontWeight.w600)
                        ..textShadow(blur: 10)
                        ..fontSize(32)..alignment.center()
                    ),
                    buildPhoneTF(),
                    buildName(),
                    buildPasswordTF(),
                    buildPasswordTFRE(),
                    // buildEmail(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Txt(
                          'الشروط والاحكام',
                          style: TxtStyle()..textColor(ColorsD.main),
                          gesture: Gestures()
                            ..onTap(() => Router.navigator.pushNamed(
                                Router.howShopping,
                                arguments: HowShoppingArguments(
                                    jsonKey: 'conditions',
                                    title: 'الشروط و الأحكام'))),
                        ),
                        Txt('بانشائك هذا الحساب فانت توافق علي '),
                      ],
                    ),
                    registerBtn()
                  ],
                ),
              ),
            ),
            Parent(
              child: Icon(Icons.arrow_back),
              gesture: Gestures()
                ..onTap(() => [Navigator.pop(context), print('s')]),
              style: ParentStyle()..margin(all: 12),
            )
          ],
        ),
      ),
    );
  }

  bool isObsecure = true;
  bool isObsecureRE = true;

  Widget buildPhoneTF() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        // textAlign: TextAlign.right,
        validator: (s) {
          if (s.length != 9 && s.length != 10) return "من فضلك ادخل رقم صحيح";
        },
        keyboardType: TextInputType.number,
        controller: phoneCtrler,
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
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

  Widget buildPasswordTF() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: passwordCtrler,
        obscureText: isObsecure,
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.black),
        validator: (s){
          if(s == null || s.length <6 )
          return 'كلمة المرور قصيرة';
        },
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

  Widget buildPasswordTFRE() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (s) {
          if (s != passwordCtrler.text) return 'كلمة المرور غير متطابقة';
        },
        obscureText: isObsecureRE,
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          // prefixText: '+966 |',
          hintText: 'تأكيد كلمة المرور',
          hintStyle: TextStyle(fontFamily: 'Cairo'),
          prefixIcon: IconButton(
            onPressed: () {
              isObsecureRE = !isObsecureRE;
              setState(() {});
            },
            icon: Icon(Icons.lock),
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: nameCtrler,
        validator: (s) {
          if (s == null || s.isEmpty) return "هذا الحقل مطلوب";
        },
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          // prefixText: '+966 |',
          hintText: 'اسم المستخدم',
          hintStyle: TextStyle(fontFamily: 'Cairo'),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: emailCtrler,
        validator: (s) {
          if (s == null || s.isEmpty) return "هذا الحقل مطلوب";
        },
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          // prefixText: '+966 |',
          hintText: 'البريد الاكتروني',
          hintStyle: TextStyle(fontFamily: 'Cairo'),
        ),
      ),
    );
  }

  Widget registerBtn() {
    
    Widget onIdleWidget = Txt(
      'انشاء حساب',
      style: StylesD.txtOnCardStyle,
      gesture: Gestures()..onTap(() => register()),
    );
    Widget onWaitingWidget =
        Parent(child: WaitingWidget(), style: StylesD.cartStyle);
    Widget onErrorWidget = Txt(
      'تعذر التسجيل،اعد المحاولة',
      style: StylesD.txtOnCardStyle,
      gesture: Gestures()..onTap(() => register()),
    );
    // Widget
    return StateBuilder(
      models: [Injector.getAsReactive<AuthStore>()],
      builder: (context, reactiveModel) => reactiveModel.whenConnectionState(
        onIdle: () => onIdleWidget,
        onWaiting: () => onWaitingWidget,
        onError: (e) {
          print(e.toString());
          return onErrorWidget;
        },
        onData: (data) {
          // Router.navigator.pop();
          return onIdleWidget;
        },
      ),
    );
  }

  register() {
    if (!formKey.currentState.validate()) {
      AlertDialogs.failed(context, content: 'من فضلك أكمل البيانات');
      return;
    }
    print('sds');
    final reactiveModel = Injector.getAsReactive<AuthStore>();
    reactiveModel.setState((state) => state
            .register(context, nameCtrler.text, '+966${phoneCtrler.text}',
                passwordCtrler.text, passwordCtrler.text, emailCtrler.text)
            .then((data) {
          if (data != null)
            AlertDialogs.success(context, content: 'تم انشاء حسابك بنجاح')
                .then((_) {
              Navigator.pop(context);
            });
        }));
  }
}
