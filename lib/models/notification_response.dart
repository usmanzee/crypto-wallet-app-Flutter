import 'dart:convert';

List<NotificationResponse> notificationResponseFromJson(String str) =>
    List<NotificationResponse>.from(
        json.decode(str).map((x) => NotificationResponse.fromJson(x)));

String notificationResponseToJson(List<NotificationResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationResponse {
  NotificationResponse({
    this.id,
    this.subject,
    this.body,
    this.expireAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String subject;
  String body;
  DateTime expireAt;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        id: json["id"],
        subject: json["subject"],
        body: json["body"],
        expireAt: DateTime.parse(json["expire_at"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "body": body,
        "expire_at": expireAt.toIso8601String(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
