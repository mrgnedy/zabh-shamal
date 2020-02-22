
import 'package:bots/core/utils.dart';
import 'package:bots/presentation/pages/account/my_account.dart';
import 'package:bots/presentation/pages/cart/cart.dart';
import 'package:bots/presentation/pages/contacts/contacts.dart';
import 'package:bots/presentation/widgets/main_page_drawer.dart';
import 'package:bots/presentation/widgets/navigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home/all_services.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int selIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Stack(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                    1 != titles.length
                        ? Container()
                        : Icon(Icons.phone_bluetooth_speaker),
                  ],
                ),
              ),
              Positioned(
                top: kToolbarHeight * .7,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    buildPhone(),
                    SizedBox(width: 10),
                    buildWhats(),
                  ],
                ),
              ),
            ],
          ),
        ),
        endDrawer: MainPageDrawer(),
        bottomNavigationBar: MainNavigationBar(
          selectPageCallback: goToPage,
        ),
        body: PageView(
          controller: pageCtrler,
          physics: NeverScrollableScrollPhysics(),
          children: [
            AccountPage(),
            ContactsPage(),
            Cart(),
            AllServices(),
          ],
        ));
  }

  List<String> titles = [
    'حسابي',
    'حساباتنا',
    'السلة',
    'ذبائح الشمال',
  ];
  String title = 'ذبائح الشمال';
  PageController pageCtrler = PageController(
    initialPage: 3,
    keepPage: true,
  );
  goToPage(int page) {
    pageCtrler.jumpToPage(page);
    title = titles[page];
    print(page);
    setState(() {});
  }

  Widget buildPhone() {
    String phoneNumber = "tel:${Urls.phoneNumber}";
    return GestureDetector(
      onTap: () => phoneCall(phoneNumber),
      child: Icon(
        Icons.phone,
        color: Colors.white,
      ),
    );
  }

  Widget buildWhats() {
    String whatsNumber =
        "https://api.whatsapp.com/send?phone=${Urls.phoneNumber}&text=${('السلام عليكم')}";
    return GestureDetector(
      onTap: () => phoneCall(whatsNumber),
      child: Icon(
        FontAwesomeIcons.whatsapp,
        color: Colors.white,
      ),
    );
  }

  phoneCall(String phone) async {
    if (await canLaunch('$phone')) await launch('$phone');
  }
}
