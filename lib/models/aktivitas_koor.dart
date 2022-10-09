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
}

class AktivitasKoor {
    AktivitasKoor({
        this.id,
        this.jadwalId,
        this.date,
        this.time,
        this.photo,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? jadwalId;
    DateTime? date;
    String? time;
    String? photo;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory AktivitasKoor.fromJson(Map<String, dynamic> json) => AktivitasKoor(
         id: json["id"],
        jadwalId: json["jadwal_id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}