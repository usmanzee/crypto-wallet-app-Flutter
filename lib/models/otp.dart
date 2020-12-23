import 'dart:convert';

Otp otpFromJson(String str) => Otp.fromJson(json.decode(str));

String otpToJson(Otp data) => json.encode(data.toJson());

class Otp {
  Otp({
    this.auth,
    this.data,
    this.metadata,
    this.leaseDuration,
    this.leaseId,
    this.renewable,
    this.warnings,
    this.wrapInfo,
  });

  dynamic auth;
  Data data;
  dynamic metadata;
  int leaseDuration;
  String leaseId;
  bool renewable;
  dynamic warnings;
  dynamic wrapInfo;

  factory Otp.fromJson(Map<String, dynamic> json) => Otp(
        auth: json["auth"],
        data: Data.fromJson(json["data"]),
        metadata: json["metadata"],
        leaseDuration: json["lease_duration"],
        leaseId: json["lease_id"],
        renewable: json["renewable"],
        warnings: json["warnings"],
        wrapInfo: json["wrap_info"],
      );

  Map<String, dynamic> toJson() => {
        "auth": auth,
        "data": data.toJson(),
        "metadata": metadata,
        "lease_duration": leaseDuration,
        "lease_id": leaseId,
        "renewable": renewable,
        "warnings": warnings,
        "wrap_info": wrapInfo,
      };
}

class Data {
  Data({
    this.barcode,
    this.url,
  });

  String barcode;
  String url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        barcode: json["barcode"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "barcode": barcode,
        "url": url,
      };
}
