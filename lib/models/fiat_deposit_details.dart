import 'dart:convert';

List<FiatDepositDetails> fiatDepositDetailsFromJson(String str) => List<FiatDepositDetails>.from(json.decode(str).map((x) => FiatDepositDetails.fromJson(x)));

String fiatDepositDetailsToJson(List<FiatDepositDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FiatDepositDetails {
    FiatDepositDetails({
        this.id,
        this.title,
        this.banks,
    });

    String id;
    String title;
    List<Bank> banks;

    factory FiatDepositDetails.fromJson(Map<String, dynamic> json) => FiatDepositDetails(
        id: json["id"],
        title: json["title"],
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
    };
}

class Bank {
    Bank({
        this.bankName,
        this.accountHolder,
        this.iban,
        this.swiftBic,
        this.address,
        this.accountNumber,
        this.achRoutingNumber,
        this.wireRoutingNumber,
        this.bankAccountNumber,
        this.accountType,
    });

    String bankName;
    String accountHolder;
    String iban;
    String swiftBic;
    String address;
    String accountNumber;
    String achRoutingNumber;
    String wireRoutingNumber;
    String bankAccountNumber;
    String accountType;

    factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        bankName: json["Bank Name"],
        accountHolder: json["Account holder"],
        iban: json["IBAN"] == null ? null : json["IBAN"],
        swiftBic: json["SWIFT/BIC"] == null ? null : json["SWIFT/BIC"],
        address: json["Address"] == null ? null : json["Address"],
        accountNumber: json["Account Number"] == null ? null : json["Account Number"],
        achRoutingNumber: json["ACH routing number"] == null ? null : json["ACH routing number"],
        wireRoutingNumber: json["Wire routing number"] == null ? null : json["Wire routing number"],
        bankAccountNumber: json["Account number"] == null ? null : json["Account number"],
        accountType: json["Account type"] == null ? null : json["Account type"],
    );

    Map<String, dynamic> toJson() => {
        "Bank Name": bankName,
        "Account holder": accountHolder,
        "IBAN": iban == null ? null : iban,
        "SWIFT/BIC": swiftBic == null ? null : swiftBic,
        "Address": address == null ? null : address,
        "Account Number": accountNumber == null ? null : accountNumber,
        "ACH routing number": achRoutingNumber == null ? null : achRoutingNumber,
        "Wire routing number": wireRoutingNumber == null ? null : wireRoutingNumber,
        "Account number": bankAccountNumber == null ? null : bankAccountNumber,
        "Account type": accountType == null ? null : accountType,
    };
}