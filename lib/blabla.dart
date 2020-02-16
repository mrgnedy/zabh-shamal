import 'package:division/division.dart';
import 'package:flutter/material.dart';

class ShowTimeBlabla extends StatefulWidget {
  @override
  _ShowTimeBlablaState createState() => _ShowTimeBlablaState();
}

class _ShowTimeBlablaState extends State<ShowTimeBlabla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Text('sdsdsdsd'),
          onTap: () =>
              showTimePicker(context: context, initialTime: TimeOfDay.now()),
        ),
      ),
    );
  }
}
