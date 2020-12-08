import 'package:finance_calulator/utils/styles.dart';
import 'package:flutter/material.dart';

import '../pie_chart.dart';

class FdScreen extends StatelessWidget {
  const FdScreen({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      color: Styles.bgColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            CustomNumberInput(hintText: "No of Months"),
            CustomNumberInput(hintText: "Rate of Interest"),
            CustomNumberInput(hintText: "Deposit Amount"),
            CustomButton(),
            SizedBox(
              height: size.width * 0.5,
              child: Container(
                // color: Colors.red,
                padding: EdgeInsets.all(15),
                child: DatumLegendWithMeasures.withSampleData([
                  {"type": "Principle", "amount": 5000},
                  {"type": "Interest", "amount": 200}
                ]),
              ),
            ),
            SizedBox(
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
                      amount: 10000,
                    ),
                    LabelTextAmount(
                      label: 'Interest:',
                      amount: 1000,
                    ),
                    Divider(
                      thickness: 2,
                      color: Styles.darkColor,
                    ),
                    LabelTextAmount(
                      label: 'Maturity:',
                      amount: 11000,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Styles.darkColor,
      ),
      child: FlatButton(
        onPressed: null,
        child: Text(
          'Calculate',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomNumberInput extends StatelessWidget {
  const CustomNumberInput({
    Key key,
    @required this.hintText,
  }) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
