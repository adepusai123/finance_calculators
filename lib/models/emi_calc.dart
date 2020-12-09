import 'dart:math';

class EMIcalculation {
  double months;
  double principle;
  double roi;
  EMIcalculation({
    this.months,
    this.principle,
    this.roi,
  });

  double rateConversion() {
    double value = roi / 12 / 100;
    return value;
  }

  double calcNominator() {
    double r = rateConversion();
    double p = pow((1 + r), months);
    double value = principle * r * p;
    return value;
  }

  double calcDenominator() {
    double R = rateConversion();
    return pow((1 + R), months) - 1;
  }

  calculate() {
    /**
     * EMI = [P *R * (1+R)^N] /[((1+R)^N)-1)]
     */
    double N = calcNominator();
    double D = calcDenominator();
    String value = (N / D).toStringAsFixed(2);
    return double.parse(value);
  }
}
