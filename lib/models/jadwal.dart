import 'dart:convert';

JadwalResult jadwalFromJson(String str) => JadwalResult.fromJson(json.decode(str));

class JadwalResult {
    JadwalResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int? code;
    String? message;
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
        required this.userId,
        required this.cleanArea,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    int? id;
    String? userId;
    String? cleanArea;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        id: json["id"],
        userId: json["user_id"],
        cleanArea: json["clean_area"],
        status: json["status"],
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
       required this.emailVerifiedAt,
       required this.password,
       required this.rememberToken,
       required this.createdAt,
       required this.updatedAt,
    });

    int? id;
    String? uid;
    String? name;
    String? address;
    String? phone;
    String? email;
    dynamic emailVerifiedAt;
    String? password;
    dynamic rememberToken;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

}
