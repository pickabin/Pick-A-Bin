import 'dart:convert';

PetugasResult petugasFromJson(String str) => PetugasResult.fromJson(json.decode(str));
class PetugasResult {
    PetugasResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<Petugas> data;

    factory PetugasResult.fromJson(Map<String, dynamic> json) => PetugasResult(
        code: json["code"],
        message: json["message"],
        data: List<Petugas>.from(json["data"].map((x) => Petugas.fromJson(x))),
    );

}

class Petugas {
    Petugas({
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

    factory Petugas.fromJson(Map<String, dynamic> json) => Petugas(
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
