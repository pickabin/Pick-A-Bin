// To parse this JSON data, do
//
//     final koorGedung = koorGedungFromJson(jsonString);

import 'dart:convert';

KoorGedungResult koorGedungFromJson(String str) => KoorGedungResult.fromJson(json.decode(str));

class KoorGedungResult {
    KoorGedungResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<KoorGedung> data;

    factory KoorGedungResult.fromJson(Map<String, dynamic> json) => KoorGedungResult(
        code: json["code"],
        message: json["message"],
        data: List<KoorGedung>.from(json["data"].map((x) => KoorGedung.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class KoorGedung {
    KoorGedung({
        required this.id,
        required this.userId,
        required this.code,
        required this.cleanArea,
        required this.photo,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String userId;
    String code;
    String cleanArea;
    String photo;
    DateTime createdAt;
    DateTime updatedAt;

    factory KoorGedung.fromJson(Map<String, dynamic> json) => KoorGedung(
        id: json["id"],
        userId: json["user_id"],
        code: json["code"],
        cleanArea: json["clean_area"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "code": code,
        "clean_area": cleanArea,
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
