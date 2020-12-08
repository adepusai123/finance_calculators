import 'dart:math';

class CompoundCalculation {
  double roi;
  int months;
  double principle;
  int cTimes;
  double maturity;

  CompoundCalculation({this.principle, this.cTimes, this.months, this.roi});

  double monthsToYears() {
    return months / 12;
  }

  double rateInFractions() {
    return roi / 100;
  }

  double calcBase() {
    /**
     *  (1 + R/N)
     *  */
    double value = (1 + (rateInFractions() / cTimes));
    return value;
  }

  double calcPower() {
    double value = (cTimes * monthsToYears());
    return value;
  }

  double calcMaturity() {
    /**
     * A = P * (1 + (R/N)) ^ NT
     */
    double ratio = pow(calcBase(), calcPower());
    String value = (principle * ratio).toStringAsFixed(0);
    return double.parse(value);
  }
}
