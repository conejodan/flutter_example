import 'dart:convert';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
  Device({
    this.id,
    this.userId,
    this.name = '',
    this.key = '',
    this.active = true,
  });

  int? id;
  int? userId;
  String name;
  String key;
  bool active;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        key: json["key"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": "$id",
        "user_id": "$userId",
        "name": name,
        "key": key,
        "active": "$active",
      };
}
