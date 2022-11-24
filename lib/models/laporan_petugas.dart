import 'dart:convert';

LaporanPetugasResult laporanPetugasFromJson(String str) => LaporanPetugasResult.fromJson(json.decode(str));


class LaporanPetugasResult {
    LaporanPetugasResult({
       required this.code,
       required this.message,
       required this.data,
    });

    int? code;
    String? message;
    List<LaporanPetugas> data;

    factory LaporanPetugasResult.fromJson(Map<String, dynamic> json) => LaporanPetugasResult(
        code: json["code"],
        message: json["message"],
        data: List<LaporanPetugas>.from(json["data"].map((x) => LaporanPetugas.fromJson(x))),
    );

}

class LaporanPetugas {
    LaporanPetugas({
       required this.id,
       required this.userId,
       required this.code,
       required this.cleanArea,
       required this.photo,
       required this.createdAt,
       required this.updatedAt,
       required this.user,
       required this.petugasActivity,
    });

    int? id;
    String? userId;
    String? code;
    String? cleanArea;
    String? photo;
    DateTime? createdAt;
    DateTime? updatedAt;
    User user;
    List<PetugasActivity> petugasActivity;

    factory LaporanPetugas.fromJson(Map<String, dynamic> json) => LaporanPetugas(
        id: json["id"],
        userId: json["user_id"],
        code: json["code"],
        cleanArea: json["clean_area"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        petugasActivity: List<PetugasActivity>.from(json["aktivitas_petugas"].map((x) => PetugasActivity.fromJson(x))),
    );
}

class PetugasActivity {
    PetugasActivity({
       required this.id,
       required this.jadwalId,
       required this.petugasId,
       required this.date,
       required this.time,
       required this.photo,
       required this.feedback,
       required this.status,
       required this.createdAt,
       required this.updatedAt,
    });

    int? id;
    String? jadwalId;
    String? petugasId;
    String? date;
    String? time;
    String? photo;
    String? feedback;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory PetugasActivity.fromJson(Map<String, dynamic> json) => PetugasActivity(
        id: json["id"],
        jadwalId: json["jadwal_id"],
        petugasId: json["petugas_id"],
        date: json["date"],
        time: json["time"],
        photo: json["photo"],
        feedback: json["feedback"] == null ? null : json["feedback"],
        status: json["status"] == null ? null : json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
