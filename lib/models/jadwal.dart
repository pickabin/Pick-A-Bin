// To parse this JSON data, do
//
//     final jadwal = jadwalFromJson(jsonString);

import 'dart:convert';

JadwalResult jadwalFromJson(String str) => JadwalResult.fromJson(json.decode(str));

class JadwalResult {
    JadwalResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<Jadwal> data;

    factory JadwalResult.fromJson(Map<String, dynamic> json) => JadwalResult(
        code: json["code"],
        message: json["message"],
        data: List<Jadwal>.from(json["data"].map((x) => Jadwal.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Jadwal {
    Jadwal({
        required this.id,
        required this.userId,
        required this.cleanArea,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String userId;
    String cleanArea;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        id: json["id"],
        userId: json["user_id"],
        cleanArea: json["clean_area"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "clean_area": cleanArea,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
