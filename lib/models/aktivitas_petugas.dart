// To parse this JSON data, do
//
//     final aktivitasPetugas = aktivitasPetugasFromJson(jsonString);

import 'dart:convert';

AktivitasPetugasResult aktivitasPetugasFromJson(String str) => AktivitasPetugasResult.fromJson(json.decode(str));

class AktivitasPetugasResult {
    AktivitasPetugasResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<AktivitasPetugas> data;

    factory AktivitasPetugasResult.fromJson(Map<String, dynamic> json) => AktivitasPetugasResult(
        code: json["code"],
        message: json["message"],
        data: List<AktivitasPetugas>.from(json["data"].map((x) => AktivitasPetugas.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AktivitasPetugas {
    AktivitasPetugas({
        required this.id,
        required this.jadwalId,
        required this.date,
        required this.time,
        required  this.photo,
        required  this.createdAt,
        required  this.updatedAt,
    });

    int id;
    String jadwalId;
    DateTime date;
    String time;
    String photo;
    DateTime createdAt;
    DateTime updatedAt;

    factory AktivitasPetugas.fromJson(Map<String, dynamic> json) => AktivitasPetugas(
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
