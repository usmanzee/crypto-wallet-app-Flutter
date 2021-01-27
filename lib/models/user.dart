// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.email,
    this.uid,
    this.role,
    this.level,
    this.otp,
    this.state,
    this.token,
    this.referralUid,
    this.csrfToken,
    this.data,
    this.createdAt,
    this.updatedAt,
    this.labels,
    this.phones,
    this.profiles,
    this.dataStorages,
  });

  String email;
  String uid;
  String role;
  int level;
  bool otp;
  String state;
  String token;
  dynamic referralUid;
  String csrfToken;
  dynamic data;
  DateTime createdAt;
  DateTime updatedAt;
  List<Label> labels;
  List<Phone> phones;
  List<Profile> profiles;
  List<dynamic> dataStorages;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        uid: json["uid"],
        role: json["role"],
        level: json["level"],
        otp: json["otp"],
        state: json["state"],
        token: json["token"],
        referralUid: json["referral_uid"],
        csrfToken: json["csrf_token"],
        data: json["data"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        labels: List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
        phones: List<Phone>.from(json["phones"].map((x) => Phone.fromJson(x))),
        profiles: List<Profile>.from(
            json["profiles"].map((x) => Profile.fromJson(x))),
        dataStorages: List<dynamic>.from(json["data_storages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "role": role,
        "level": level,
        "otp": otp,
        "state": state,
        "token": token,
        "referral_uid": referralUid,
        "csrf_token": csrfToken,
        "data": data,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "labels": List<dynamic>.from(labels.map((x) => x.toJson())),
        "phones": List<dynamic>.from(phones.map((x) => x.toJson())),
        "profiles": List<dynamic>.from(profiles.map((x) => x.toJson())),
        "data_storages": List<dynamic>.from(dataStorages.map((x) => x)),
      };
}

class Label {
  Label({
    this.key,
    this.value,
    this.scope,
    this.createdAt,
    this.updatedAt,
  });

  String key;
  String value;
  String scope;
  DateTime createdAt;
  DateTime updatedAt;

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        key: json["key"],
        value: json["value"],
        scope: json["scope"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "scope": scope,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Phone {
  Phone({
    this.country,
    this.number,
    this.validatedAt,
  });

  String country;
  String number;
  DateTime validatedAt;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        country: json["country"],
        number: json["number"],
        validatedAt: json["validated_at"] == null
            ? null
            : DateTime.parse(json["validated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "number": number,
        "validated_at":
            validatedAt == null ? null : validatedAt.toIso8601String(),
      };
}

class Profile {
  Profile({
    this.firstName,
    this.lastName,
    this.dob,
    this.address,
    this.postcode,
    this.city,
    this.country,
    this.state,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  String firstName;
  String lastName;
  DateTime dob;
  String address;
  String postcode;
  String city;
  String country;
  String state;
  dynamic metadata;
  DateTime createdAt;
  DateTime updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        firstName: json["first_name"],
        lastName: json["last_name"],
        dob: DateTime.parse(json["dob"]),
        address: json["address"],
        postcode: json["postcode"],
        city: json["city"],
        country: json["country"],
        state: json["state"],
        metadata: json["metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "address": address,
        "postcode": postcode,
        "city": city,
        "country": country,
        "state": state,
        "metadata": metadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
