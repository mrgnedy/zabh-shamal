import 'package:bots/core/utils.dart';
import 'package:bots/presentation/state/cart_store.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class CounterBar extends StatefulWidget {
  final int index;

  const CounterBar(this.index);
  @override
  _CounterBarState createState() => _CounterBarState();
}

class _CounterBarState extends State<CounterBar> {
  int counter;
  ReactiveModel<CartStore> reactiveModel;
  @override
  void initState() {
    reactiveModel = Injector.getAsReactive<CartStore>();
    counter=reactiveModel.state.cartCounters[widget.index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              if (counter > 1) counter--;
              {
                print('j');
                // widget.callback(counter, widget.index);
                reactiveModel.setState(
                    (state) => state.cartCounters[widget.index] = counter);
                // if (mounted) setState(() {});
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
          InkWell(
            onTap: () {
              counter++;
              // widget.callback(counter, widget.index);
              reactiveModel.setState(
                  (state) => state.cartCounters[widget.index] = counter);
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
