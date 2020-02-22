import 'package:bots/data/models/my_orders_model.dart';
import 'package:bots/presentation/widgets/general_cart.dart';
import 'package:flutter/material.dart';

class OrderProductcsPage extends StatelessWidget {
  final String title;
  final List<OrderProducts> products;

  const OrderProductcsPage({Key key, this.title, this.products})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.title}'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: List.generate(products.length, (index){
          return GCartItem(cartItem: products[index],);
        })
      ),
    );
  }
}
