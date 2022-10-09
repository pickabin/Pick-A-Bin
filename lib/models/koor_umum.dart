// To parse this JSON data, do
//
//     final koorUmum = koorUmumFromJson(jsonString);

import 'dart:convert';

KoorUmumResult koorUmumFromJson(String str) => KoorUmumResult.fromJson(json.decode(str));

class KoorUmumResult {
    KoorUmumResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<koorUmum> data;

    factory KoorUmumResult.fromJson(Map<String, dynamic> json) => KoorUmumResult(
        code: json["code"],
        message: json["message"],
        data: List<koorUmum>.from(json["data"].map((x) => koorUmum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class koorUmum {
    koorUmum({
        required this.id,
        required this.userId,
        required this.photo,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String userId;
    String photo;
    DateTime createdAt;
    DateTime updatedAt;

    factory koorUmum.fromJson(Map<String, dynamic> json) => koorUmum(
        id: json["id"],
        userId: json["user_id"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
