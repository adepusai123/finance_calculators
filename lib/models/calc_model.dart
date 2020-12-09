// To parse this JSON data, do
//
//     final calcModel = calcModelFromJson(jsonString);

import 'dart:convert';

CalcModel calcModelFromJson(String str) => CalcModel.fromJson(json.decode(str));

String calcModelToJson(CalcModel data) => json.encode(data.toJson());

class CalcModel {
  CalcModel({
    this.roi,
    this.months,
    this.principle,
    this.cTimes,
  });

  double roi;
  double months;
  double principle;
  int cTimes;

  factory CalcModel.fromJson(Map<String, dynamic> json) => CalcModel(
        roi: double.parse(json["roi"]),
        months: double.parse(json["months"]),
        principle: double.parse(json["principle"]),
        cTimes: json["cTimes"],
      );

  Map<String, dynamic> toJson() => {
        "roi": roi,
        "months": months,
        "principle": principle,
        "cTimes": cTimes,
      };
}
