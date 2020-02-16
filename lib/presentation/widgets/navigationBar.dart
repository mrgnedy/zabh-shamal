import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainNavigationBar extends StatefulWidget {
  final Function selectPageCallback;
  MainNavigationBar({this.selectPageCallback});
  @override
  _MainNavigationBarState createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int selIndex = 3;
  @override
  Widget build(BuildContext context) {
    return FFNavigationBar(
      onSelectTab: (s) {
        selIndex = s;
        widget.selectPageCallback(s);
        setState(() {});
      },
      selectedIndex: selIndex,
      theme: FFNavigationBarTheme(
        unselectedItemIconColor: Colors.black,
        selectedItemBackgroundColor: Colors.cyan,
        selectedItemLabelColor: Colors.cyan,
        unselectedItemLabelColor: Colors.black,
      ),
      items: [
        FFNavigationBarItem(
          iconData: Icons.person,
          label: 'حسابي',
        ),
        FFNavigationBarItem(
          iconData: Icons.credit_card,
          label: 'حسباتنا',
        ),
        FFNavigationBarItem(
          iconData: Icons.shopping_cart,
          label: 'السلة',
        ),
        FFNavigationBarItem(
          iconData: Icons.home,
          label: 'الرئيسية',
        ),
      ],
    );
  }
}
