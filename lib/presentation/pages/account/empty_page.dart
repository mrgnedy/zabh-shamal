import 'package:bots/core/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String title;
  final String content;

  const EmptyPage({Key key, this.title, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Center(
          child: ListView(shrinkWrap: true, children: [
            Txt(
              content,
              style: StylesD.txtStyle.clone()
                ..alignment.center()
                ..fontSize(20)
                ..margin(all: 10),
            ),
          ]),
        ),
      );
  }
}
