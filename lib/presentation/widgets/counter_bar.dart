import 'package:bots/core/utils.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class CounterBar extends StatefulWidget {
  final Function callback;
  final int index;

  const CounterBar(this.callback, this.index);
  @override
  _CounterBarState createState() => _CounterBarState();
}

class _CounterBarState extends State<CounterBar> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (counter > 1) counter--;
              {
                widget.callback(counter, widget.index);
                if (mounted) setState(() {});
              }
            },
            child: Icon(
              Icons.remove_circle_outline,
              color: ColorsD.main,
            ),
          ),
          Txt(
            '$counter',
            style: TxtStyle()
              ..textColor(ColorsD.main)
              ..padding(horizontal: 10),
          ),
          GestureDetector(
            onTap: () {
              counter++;
              widget.callback(counter, widget.index);
              if (mounted) setState(() {});
            },
            child: Icon(
              Icons.add_circle_outline,
              color: ColorsD.main,
            ),
          ),
        ],
      ),
    );
  }
}
