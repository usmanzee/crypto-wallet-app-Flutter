import 'dart:convert';

SparkLineResponse sparkLineResponseFromJson(String str) =>
    SparkLineResponse.fromJson(json.decode(str));

String sparkLineResponseToJson(SparkLineResponse data) =>
    json.encode(data.toJson());

class SparkLineResponse {
  SparkLineResponse({
    this.data,
  });

  List<Datum> data;

  factory SparkLineResponse.fromJson(Map<String, dynamic> json) =>
      SparkLineResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.data,
    this.title,
    this.description,
    this.shape,
    this.url,
  });

  List<double> data;
  String title;
  List<dynamic> description;
  List<dynamic> shape;
  List<dynamic> url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        data: List<double>.from(json["data"].map((x) => x.toDouble())),
        title: json["title"],
        description: List<dynamic>.from(json["description"].map((x) => x)),
        shape: List<dynamic>.from(json["shape"].map((x) => x)),
        url: List<dynamic>.from(json["url"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
        "title": title,
        "description": List<dynamic>.from(description.map((x) => x)),
        "shape": List<dynamic>.from(shape.map((x) => x)),
        "url": List<dynamic>.from(url.map((x) => x)),
      };
}
