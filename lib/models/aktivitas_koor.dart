import 'dart:convert';

AktivitasKoorResult aktivitasKoorFromJson(String str) => AktivitasKoorResult.fromJson(json.decode(str));


class AktivitasKoorResult {
    AktivitasKoorResult({
       required this.code,
       required this.message,
       required this.data,
    });

    int? code;
    String? message;
    List<AktivitasKoor> data;

    factory AktivitasKoorResult.fromJson(Map<String, dynamic> json) => AktivitasKoorResult(
        code: json["code"],
        message: json["message"],
        data: List<AktivitasKoor>.from(json["data"].map((x) => AktivitasKoor.fromJson(x))),
    );

}

class AktivitasKoor {
    AktivitasKoor({
       required this.id,
       required this.jadwalId,
       required this.koorGedungId,
       required this.date,
       required this.time,
       required this.photo,
       required this.createdAt,
       required this.updatedAt,
       required this.jadwal,
    });

    int? id;
    String? jadwalId;
    String? koorGedungId;
    String? date;
    String? time;
    String? photo;
    DateTime? createdAt;
    DateTime? updatedAt;
    Jadwal jadwal;

    factory AktivitasKoor.fromJson(Map<String, dynamic> json) => AktivitasKoor(
        id: json["id"],
        jadwalId: json["jadwal_id"],
        koorGedungId: json["koor_gedung_id"],
        date: json["date"],
        time: json["time"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        jadwal: Jadwal.fromJson(json["jadwal"]),
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
    User user;

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
       required this.photo,
       required this.createdAt,
       required this.updatedAt,
    });

    int id;
    String uid;
    String name;
    String address;
    String phone;
    String email;
    dynamic emailVerifiedAt;
    String password;
    dynamic rememberToken;
    String photo;
    DateTime createdAt;
    DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        address: json["address"].toString(),
        phone: json["phone"].toString(),
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        rememberToken: json["remember_token"],
        photo: json["photo"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

}
