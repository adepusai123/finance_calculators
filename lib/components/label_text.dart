import 'package:finance_calulator/utils/styles.dart';
import 'package:flutter/material.dart';

class LabelTextAmount extends StatelessWidget {
  const LabelTextAmount({
    Key key,
    this.label,
    this.amount,
  }) : super(key: key);

  final String label;
  final double amount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Styles.greyTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            '$amount',
            style: TextStyle(
              color: Styles.darkColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
