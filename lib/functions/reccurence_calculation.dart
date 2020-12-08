import 'package:finance_calulator/functions/compound_calculation.dart';

class RDCalculation {
  double roi;
  int months;
  double principle;
  int cTimes;
  double maturity;
  RDCalculation({
    this.roi,
    this.months,
    this.principle,
    this.cTimes,
  });

  double calculate() {
    double value = 0;
    for (double i = 0; i < months; i++) {
      CompoundCalculation cc = new CompoundCalculation(
        principle: principle,
        cTimes: cTimes,
        roi: roi,
        months: months - i,
      );
      value += cc.calcMaturity();
    }
    return value;
  }
}
