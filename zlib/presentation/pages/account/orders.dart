import 'package:bots/core/utils.dart';
import 'package:bots/data/models/my_orders_model.dart';
import 'package:bots/presentation/router.gr.dart';
import 'package:bots/presentation/state/account_store.dart';
import 'package:bots/presentation/widgets/error_widget.dart';
import 'package:bots/presentation/widgets/general_cart.dart';
import 'package:bots/presentation/widgets/idle_widget.dart';
import 'package:bots/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    final reactiveModel = Injector.getAsReactive<AccountStore>();
    reactiveModel.setState((state) => state.getMyOrders(context));
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
          child: StateBuilder<AccountStore>(
              models: [Injector.getAsReactive<AccountStore>()],
              builder: (context, reactiveModel) =>
                  reactiveModel.whenConnectionState(
                    onIdle: () => IdleWidget(),
                    onWaiting: () => WaitingWidget(),
                    onError: (e) => OnErrorWidget(),
                    onData: (data) => ordersWidget(data.myOrdersModel.data),
                  ))),
    );
  }

  Widget ordersWidget(Data orders) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBar(
              controller: tabController,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: ColorsD.main),
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
              currentOrders(orders.finishorders),
              currentOrders(orders.initorders),
            ],
          ),
        ),
      ],
    );
  }

  Widget currentOrders(List<Initorders> currentOrders) {
    // List<Initorders> subCurrentOrders = []..add(currentOrders.first);
    // List<OrderProduct> subCurrentOrderProducts = []
    //   ..add(currentOrders.first.product);
    // for (int i = 1; i <= currentOrders.length; i++) {
    //   if (currentOrders[i].orderId == currentOrders[i - 1].orderId)
    //     subCurrentOrderProducts.add(currentOrders[i].product);
    //   else
    //     subCurrentOrders.add(currentOrders[i]);
    // }
    return ListView(
        shrinkWrap: true,
        children: List.generate(currentOrders.length, (i) {
          return orderItem(currentOrders[i]);
        }));
  }

  Widget orderItem(Initorders order) {
    String createdTime = DateTime.parse(order.order.first.createdAt).add(Duration(hours: 2)).toString().replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩')
        .replaceAll('0', '٠')
        .replaceAll('-', '/');
    return Parent(
      gesture: Gestures() 
        ..onTap(() => Router.navigator.pushNamed(Router.orderProductcsPage,
            arguments: OrderProductcsPageArguments(title: 'تفاصيل الطلب',products: order.orderProducts) )),
      style: StylesD.cartStyle,
      child: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                final reactiveModel = Injector.getAsReactive<AccountStore>();
                reactiveModel.setState((state) => state
                    .delOrder(context, order.order.first.id)
                    .then((_) => state.getMyOrders(context)));
              },
              child: Icon(FontAwesomeIcons.trashAlt),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'رقم الطلب:  ',
                          style: TextStyle(
                              color: ColorsD.main, fontFamily: 'Cairo'),
                        ),
                        TextSpan(
                          text: '${order.order.first.id}',
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Cairo'),
                        ),
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'تاريخ الطلب:  ',
                        style:
                            TextStyle(color: ColorsD.main, fontFamily: 'Cairo'),
                      ),
                      TextSpan(
                        text: '${createdTime.split(' ')[1].split('.')[0]}  ${createdTime.split(' ')[0]}',
                        style:
                            TextStyle(color: Colors.black,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Align(alignment: Alignment.,child: ,),
          // Align(alignment: Alignment.,child: ,),
        ],
      ),
    );
  }
}
