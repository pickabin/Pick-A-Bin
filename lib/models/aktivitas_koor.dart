// To parse this JSON data, do
//
//     final aktivitasKoor = aktivitasKoorFromJson(jsonString);

import 'dart:convert';

AktivitasKoorResult aktivitasKoorFromJson(String str) => AktivitasKoorResult.fromJson(json.decode(str));

class AktivitasKoorResult {
    AktivitasKoorResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<AktivitasKoor> data;

    factory AktivitasKoorResult.fromJson(Map<String, dynamic> json) => AktivitasKoorResult(
        code: json["code"],
        message: json["message"],
        data: List<AktivitasKoor>.from(json["data"].map((x) => AktivitasKoor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AktivitasKoor {
    AktivitasKoor({
        required this.id,
        required this.jadwalId,
        required this.date,
        required this.time,
        required this.photo,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String jadwalId;
    DateTime date;
    String time;
    String photo;
    DateTime createdAt;
    DateTime updatedAt;

    factory AktivitasKoor.fromJson(Map<String, dynamic> json) => AktivitasKoor(
        id: json["id"],
        jadwalId: json["jadwal_id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jadwal_id": jadwalId,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
