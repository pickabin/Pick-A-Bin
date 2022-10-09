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
}

class AktivitasPetugas {
    AktivitasPetugas({
        required this.id,
        required this.jadwalId,
        required this.date,
        required this.time,
        required this.photo,
        required this.createdAt,
        required this.updatedAt,
    });

    int? id;
    String? jadwalId;
    DateTime? date;
    String? time;
    String? photo;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory AktivitasPetugas.fromJson(Map<String, dynamic> json) => AktivitasPetugas(
        id: json["id"],
        jadwalId: json["jadwal_id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}