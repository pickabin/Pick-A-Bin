import 'dart:convert';

KoorUmum koorUmumFromJson(String str) => KoorUmum.fromJson(json.decode(str));

class KoorUmumResult {
    KoorUmumResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<KoorUmum> data;

    factory KoorUmumResult.fromJson(Map<String, dynamic> json) => KoorUmumResult(
        code: json["code"],
        message: json["message"],
        data: List<KoorUmum>.from(json["data"].map((x) => KoorUmum.fromJson(x))),
    );
}

class KoorUmum {
    KoorUmum({
        required this.id,
        required this.uid,
        required this.koorCode,
        required this.cleanArea,
        required this.name,
        required this.address,
        required this.phone,
        required this.email,
        this.photo,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String uid;
    String koorCode;
    String cleanArea;
    String name;
    String address;
    String phone;
    String email;
    dynamic photo;
    DateTime createdAt;
    DateTime updatedAt;

    factory KoorUmum.fromJson(Map<String, dynamic> json) => KoorUmum(
        id: json["id"],
        uid: json["uid"],
        koorCode: json["koor_code"],
        cleanArea: json["clean_area"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}