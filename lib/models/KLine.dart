import 'dart:convert';

List<List<double>> kLineFromJson(String str) => List<List<double>>.from(
    json.decode(str).map((x) => List<double>.from(x.map((x) => x.toDouble()))));

String kLineToJson(List<List<double>> data) => json.encode(
    List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))));
