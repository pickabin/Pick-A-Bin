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
        required this.userId,
        required this.code,
        required this.cleanArea,
        required this.photo,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    int id;
    String? userId;
    String? code;
    String? cleanArea;
    String? photo;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    factory Petugas.fromJson(Map<String, dynamic> json) => Petugas(
        id: json["id"],
        userId: json["user_id"],
        code: json["code"],
        cleanArea: json["clean_area"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

}

class User {
    User({
        required this.id,
        required this.uid,
        required this.name,
        required this.address,
        required this.phone,
        required this.email,
        required this.imageUrl,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String? uid;
    String? name;
    String? address;
    String? phone;
    String? email;
    String? imageUrl;
    String? emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        imageUrl: json["image_url"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );


}