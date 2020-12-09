import 'package:finance_calulator/components/custom_button.dart';
import 'package:finance_calulator/components/custom_text_field.dart';
import 'package:finance_calulator/components/label_text.dart';
import 'package:finance_calulator/functions/compound_calculation.dart';
import 'package:finance_calulator/functions/reccurence_calculation.dart';
import 'package:finance_calulator/models/calc_model.dart';
import 'package:finance_calulator/models/chart_model.dart';
import 'package:finance_calulator/utils/styles.dart';
import 'package:flutter/material.dart';

import '../pie_chart.dart';

class FdScreen extends StatefulWidget {
  const FdScreen({
    Key key,
    @required this.name,
    @required this.id,
  }) : super(key: key);

  final String name;
  final String id;

  @override
  _FdScreenState createState() => _FdScreenState();
}

class _FdScreenState extends State<FdScreen> {
  TextEditingController monthsCtrl = new TextEditingController();
  TextEditingController roiCtrl = new TextEditingController();
  TextEditingController prinCtrl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<ChartData> dataSet = [];
  double tA;
  double tI;
  double tP;
  bool showResult = false;

  @override
  Widget build(BuildContext context) {
    String id = widget.id;
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      color: Styles.bgColor,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              CustomNumberInput(
                hintText: "No of Months",
                controller: monthsCtrl,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  validateNumberField(value, monthsCtrl);
                },
              ),
              CustomNumberInput(
                hintText: "Rate of Interest",
                controller: roiCtrl,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  validateNumberField(value, roiCtrl);
                },
              ),
              CustomNumberInput(
                hintText: id == "FD" ? "Deposit Amount" : "Monthly Deposit",
                controller: prinCtrl,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  validateNumberField(value, roiCtrl);
                },
              ),
              CustomButton(
                label: 'Calculate',
                press: () {
                  setState(() {
                    dataSet = [];
                  });
                  FocusScope.of(context)
                      .requestFocus(FocusNode()); // close keyboard on click
                  if (_formKey.currentState.validate()) {
                    tP = stringToNumber(prinCtrl.text);
                    if (id == 'FD') {
                      CalcModel data = new CalcModel.fromJson({
                        "roi": roiCtrl.text,
                        "months": monthsCtrl.text,
                        "principle": prinCtrl.text,
                        "cTimes": 4
                      });
                      tP = data.principle;
                      CompoundCalculation calc = new CompoundCalculation(
                        roi: data.roi,
                        months: data.months,
                        principle: data.principle,
                        cTimes: data.cTimes,
                      );
                      tA = calc.calcMaturity();
                      tI = tA - stringToNumber(prinCtrl.text);
                    } else if (id == "RD") {
                      CalcModel data = new CalcModel.fromJson({
                        "roi": roiCtrl.text,
                        "months": monthsCtrl.text,
                        "principle": prinCtrl.text,
                        "cTimes": 12
                      });
                      RDCalculation calc = new RDCalculation(
                        roi: data.roi,
                        months: data.months,
                        principle: data.principle,
                        cTimes: data.cTimes,
                      );
                      tP = calc.investment();
                      tA = calc.calculate();
                      tI = tA - tP;
                    } else {
                      print("In progress");
                    }
                    ChartData dataP =
                        new ChartData(type: "Deposite", amount: tP);
                    dataSet.add(dataP);
                    ChartData dataI =
                        new ChartData(type: "Interest", amount: tI);
                    dataSet.add(dataI);
                    if (dataSet.length > 0) {
                      setState(() {
                        showResult = true;
                      });
                    }
                  }
                },
              ),
              ...showResult
                  ? [
                      SizedBox(
                        height: size.width * 0.5,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child:
                              DatumLegendWithMeasures.withSampleData(dataSet),
                        ),
                      ),
                      ResultCard(a: tA, p: tP, i: tI),
                      CustomButton(
                        label: 'Clear',
                        press: () {
                          setState(() {
                            dataSet = [];
                            showResult = false;
                            monthsCtrl.clear();
                            roiCtrl.clear();
                            prinCtrl.clear();
                          });
                        },
                      )
                    ]
                  : []
            ],
          ),
        ),
      ),
    );
  }

  validateNumberField(String val, TextEditingController ctrl) {
    try {
      double.parse(val);
      // ctrl.text = val;
    } catch (e) {
      return 'Enter number only';
    }
    return null;
  }

  stringToNumber(val) {
    return double.parse(val);
  }
}

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
