import 'package:finance_calulator/components/custom_button.dart';
import 'package:finance_calulator/components/custom_text_field.dart';
import 'package:finance_calulator/components/label_text.dart';
import 'package:finance_calulator/components/result_card.dart';
import 'package:finance_calulator/functions/compound_calculation.dart';
import 'package:finance_calulator/functions/reccurence_calculation.dart';
import 'package:finance_calulator/models/calc_model.dart';
import 'package:finance_calulator/models/chart_model.dart';
import 'package:finance_calulator/models/emi_calc.dart';
import 'package:finance_calulator/utils/styles.dart';
import 'package:flutter/material.dart';

import '../pie_chart.dart';

class FdScreen extends StatefulWidget {
  const FdScreen({
    Key key,
    @required this.id,
  }) : super(key: key);

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
  double tEmi;
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
                hintText: id == "EMI" ? "Loan Amount" : "Deposit Amount",
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
                  FocusScope.of(context)
                      .requestFocus(FocusNode()); // close keyboard on click
                  setState(() {
                    dataSet = [];
                  });
                  if (_formKey.currentState.validate()) {
                    if (id == 'FD') {
                      CalcModel data = new CalcModel.fromJson({
                        "roi": roiCtrl.text,
                        "months": monthsCtrl.text,
                        "principle": prinCtrl.text,
                        "cTimes": 4
                      });
                      buildCalculateFD(data);
                    } else if (id == "RD") {
                      CalcModel data = new CalcModel.fromJson({
                        "roi": roiCtrl.text,
                        "months": monthsCtrl.text,
                        "principle": prinCtrl.text,
                        "cTimes": 12
                      });
                      buildCalculateRD(data);
                    } else if (id == "EMI") {
                      CalcModel data = new CalcModel.fromJson({
                        "roi": roiCtrl.text,
                        "months": monthsCtrl.text,
                        "principle": prinCtrl.text,
                        "cTimes": 1
                      });
                      buildCalculateEMI(data);
                    } else {
                      print("No functionality here");
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
                      ...id == "EMI"
                          ? [
                              SizedBox(
                                height: size.height * 0.06,
                                width: size.width * 0.5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: LabelTextAmount(
                                    label: 'EMI:',
                                    amount: tEmi,
                                  ),
                                ),
                              )
                            ]
                          : [],
                      SizedBox(
                        height: size.width * 0.35,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child:
                              DatumLegendWithMeasures.withSampleData(dataSet),
                        ),
                      ),
                      ResultCard(a: tA, p: tP, i: tI),
                      CustomButton(
                        label: 'Clear',
                        press: () {
                          setState(() {
                            _formKey.currentState.reset();
                            dataSet = [];
                            tA = 0;
                            tI = 0;
                            tP = 0;
                            tEmi = 0;
                            showResult = false;
                            monthsCtrl.clear();
                            roiCtrl.clear();
                            prinCtrl.clear();
                          });
                        },
                      ),
                    ]
                  : [
                      CustomButton(
                        label: "Clear",
                        press: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _formKey.currentState.reset();
                        },
                      ),
                    ]
            ],
          ),
        ),
      ),
    );
  }

  buildCalculateFD(CalcModel data) {
    tP = data.principle;
    CompoundCalculation calc = new CompoundCalculation(
      roi: data.roi,
      months: data.months,
      principle: data.principle,
      cTimes: data.cTimes,
    );
    tA = calc.calcMaturity();
    tI = tA - data.principle;
  }

  buildCalculateRD(CalcModel data) {
    RDCalculation calc = new RDCalculation(
      roi: data.roi,
      months: data.months,
      principle: data.principle,
      cTimes: data.cTimes,
    );
    tP = calc.investment();
    tA = calc.calculate();
    tI = tA - tP;
  }

  buildCalculateEMI(CalcModel data) {
    EMIcalculation calc = new EMIcalculation(
        roi: data.roi, months: data.months, principle: data.principle);
    tP = calc.principle;
    tEmi = calc.calculate();
    tA = tEmi * calc.months;
    tI = double.parse((tA - tP).toStringAsFixed(2));
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
