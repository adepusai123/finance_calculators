import 'package:finance_calulator/utils/styles.dart';
import 'package:flutter/material.dart';

import 'dd_screen.dart';
import 'emi_screen.dart';
import 'fd_screen.dart';

class CalcBodyScreen extends StatelessWidget {
  const CalcBodyScreen({
    Key key,
    @required this.name,
    @required this.id,
  }) : super(key: key);

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Styles.darkColor,
        ),
        body: buildShowScreenById(id),
      ),
    );
  }

  buildShowScreenById(String id) {
    switch (id) {
      case "FD":
        return FdScreen(name: "Fixed", id: id);
        break;
      case "RD":
        return FdScreen(name: "Recurrence", id: id);
        break;
      case "DD":
        return DdScreen(name: "Daily");
        break;
      case "EMI":
        return EmiScreen(name: "EMI");
        break;
    }
  }
}
