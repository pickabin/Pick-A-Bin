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
}

class KoorGedung {
    KoorGedung({
        required this.id,
        required this.uid,
        required this.name,
        required this.address,
        required this.phone,
        required this.code,
        required this.email,
        required this.photo,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String? uid;
    String? name;
    String? address;
    String? phone;
    String? code;
    String? email;
    String? photo;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory KoorGedung.fromJson(Map<String, dynamic> json) => KoorGedung(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        code: json["code"],
        email: json["email"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}