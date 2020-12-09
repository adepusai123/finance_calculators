import 'package:finance_calulator/utils/styles.dart';
import 'package:flutter/material.dart';

import 'label_text.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    Key key,
    this.p,
    this.i,
    this.a,
  }) : super(key: key);

  final double p;
  final double i;
  final double a;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Styles.darkColor),
          color: Styles.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              spreadRadius: 1,
              blurRadius: 0.6,
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LabelTextAmount(
              label: 'Deposited:',
              amount: p,
            ),
            LabelTextAmount(
              label: 'Interest:',
              amount: i,
            ),
            Divider(
              thickness: 2,
              color: Styles.darkColor,
            ),
            LabelTextAmount(
              label: 'Maturity:',
              amount: a,
            ),
          ],
        ),
      ),
    );
  }
}
