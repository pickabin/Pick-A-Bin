import 'dart:convert';

LaporKotorResult laporKotorFromJson(String str) => LaporKotorResult.fromJson(json.decode(str));

class LaporKotorResult {
    LaporKotorResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<LaporKotor> data;

    factory LaporKotorResult.fromJson(Map<String, dynamic> json) => LaporKotorResult(
        code: json["code"],
        message: json["message"],
        data: List<LaporKotor>.from(json["data"].map((x) => LaporKotor.fromJson(x))),
    );
}

class LaporKotor {
    LaporKotor({
        required this.id,
        required this.koorCode,
        required this.cleanArea,
        required this.photo,
        required this.deskripsi,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String? koorCode;
    String? cleanArea;
    String? photo;
    String? deskripsi;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory LaporKotor.fromJson(Map<String, dynamic> json) => LaporKotor(
        id: json["id"],
        koorCode: json["koor_code"],
        cleanArea: json["clean_area"],
        photo: json["photo"],
        status: json["status"],
        deskripsi: json["deskripsi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}