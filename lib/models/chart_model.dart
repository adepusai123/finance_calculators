import 'dart:convert';

ChartData chartDataFromJson(String str) => ChartData.fromJson(json.decode(str));

String chartDataToJson(ChartData data) => json.encode(data.toJson());

class ChartData {
  ChartData({
    this.type,
    this.amount,
  });

  String type;
  double amount;

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
        type: json["type"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
      };
}
