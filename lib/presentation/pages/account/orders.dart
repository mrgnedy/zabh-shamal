import 'package:bots/core/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Txt(
          'طلباتي',
          style: TxtStyle()
            ..fontFamily('Cairo')
            ..textColor(Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                  controller: tabController,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorsD.main),
                  tabs: [
                    Tab(
                        child: Text('طلبات منتهية',
                            style: TextStyle(fontFamily: 'Cairo'))),
                    Tab(
                        child: Text('طلبات حالية',
                            style: TextStyle(fontFamily: 'Cairo'))),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  FlutterLogo(
                    size: 100,
                  ),
                  FlutterLogo(
                    size: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
