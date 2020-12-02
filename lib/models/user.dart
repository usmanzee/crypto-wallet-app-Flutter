class User {
  String email;
  String uid;
  String role;
  int level;
  bool otp;
  String state;
  Null referralUid;
  String data;
  String createdAt;
  String updatedAt;
  List<Labels> labels;
  List<Phones> phones;
  List<Profiles> profiles;
  // List<Null> dataStorages;

  User({
        this.email,
        this.uid,
        this.role,
        this.level,
        this.otp,
        this.state,
        this.referralUid,
        this.data,
        this.createdAt,
        this.updatedAt,
        this.labels,
        this.phones,
        this.profiles,
        // this.dataStorages
      });

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
    role = json['role'];
    level = json['level'];
    otp = json['otp'];
    state = json['state'];
    referralUid = json['referral_uid'];
    data = json['data'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['labels'] != null) {
      labels = new List<Labels>();
      json['labels'].forEach((v) {
        labels.add(new Labels.fromJson(v));
      });
    }
    if (json['phones'] != null) {
      phones = new List<Phones>();
      json['phones'].forEach((v) {
        phones.add(new Phones.fromJson(v));
      });
    }
    if (json['profiles'] != null) {
      profiles = new List<Profiles>();
      json['profiles'].forEach((v) {
        profiles.add(new Profiles.fromJson(v));
      });
    }
    // if (json['data_storages'] != null) {
    //   dataStorages = new List<Null>();
    //   json['data_storages'].forEach((v) {
    //     dataStorages.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['uid'] = this.uid;
    data['role'] = this.role;
    data['level'] = this.level;
    data['otp'] = this.otp;
    data['state'] = this.state;
    data['referral_uid'] = this.referralUid;
    data['data'] = this.data;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.labels != null) {
      data['labels'] = this.labels.map((v) => v.toJson()).toList();
    }
    if (this.phones != null) {
      data['phones'] = this.phones.map((v) => v.toJson()).toList();
    }
    if (this.profiles != null) {
      data['profiles'] = this.profiles.map((v) => v.toJson()).toList();
    }
    // if (this.dataStorages != null) {
    //   data['data_storages'] = this.dataStorages.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Labels {
  String key;
  String value;
  String scope;
  String createdAt;
  String updatedAt;

  Labels({this.key, this.value, this.scope, this.createdAt, this.updatedAt});

  Labels.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    scope = json['scope'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['scope'] = this.scope;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Phones {
  String country;
  String number;
  String validatedAt;

  Phones({this.country, this.number, this.validatedAt});

  Phones.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    number = json['number'];
    validatedAt = json['validated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['number'] = this.number;
    data['validated_at'] = this.validatedAt;
    return data;
  }
}

class Profiles {
  String firstName;
  String lastName;
  String dob;
  String address;
  String postcode;
  String city;
  String country;
  String state;
  String metadata;
  String createdAt;
  String updatedAt;

  Profiles(
      {this.firstName,
        this.lastName,
        this.dob,
        this.address,
        this.postcode,
        this.city,
        this.country,
        this.state,
        this.metadata,
        this.createdAt,
        this.updatedAt});

  Profiles.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    dob = json['dob'];
    address = json['address'];
    postcode = json['postcode'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    metadata = json['metadata'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['metadata'] = this.metadata;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}