import 'dart:convert';

AktivitasPetugasResult aktivitasPetugasFromJson(String str) => AktivitasPetugasResult.fromJson(json.decode(str));


class AktivitasPetugasResult {
    AktivitasPetugasResult({
       required this.code,
       required this.message,
       required this.data,
    });

    int? code;
    String? message;
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
       required this.feedback,
       required this.status,
       required this.createdAt,
       required this.updatedAt,
       required this.jadwal,
    });

    int? id;
    String? jadwalId;
    String? date;
    String? time;
    String? photo;
    String? feedback;
    int? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Jadwal jadwal;

    factory AktivitasPetugas.fromJson(Map<String, dynamic> json) => AktivitasPetugas(
        id: json["id"],
        jadwalId: json["jadwal_id"],
        date: json["date"],
        time: json["time"],
        photo: json["photo"],
        feedback: json["feedback"],
        // konversi int 
        status: json["status"] == null ? null : int.parse(json["status"]),
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

    Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "name": name,
        "address": address,
        "phone": phone,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "remember_token": rememberToken,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
