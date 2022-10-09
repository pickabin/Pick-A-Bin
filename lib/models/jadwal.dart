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
}

class Jadwal {
    Jadwal({
        required this.id,
        required this.uid,
        required this.cleanArea,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String? uid;
    String? cleanArea;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        id: json["id"],
        uid: json["uid"],
        cleanArea: json["clean_area"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}
