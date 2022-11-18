// To parse this JSON data, do
//
//     final AktivitasPetugasResult = AktivitasPetugasResultFromJson(jsonString);

import 'dart:convert';

AktivitasPetugasResult aktivitasPetugasFromJson(String str) =>
    AktivitasPetugasResult.fromJson(json.decode(str));

class AktivitasPetugasResult {
  AktivitasPetugasResult({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<AktivitasPetugas> data;

  factory AktivitasPetugasResult.fromJson(Map<String, dynamic> json) =>
      AktivitasPetugasResult(
        code: json["code"],
        message: json["message"],
        data: List<AktivitasPetugas>.from(
            json["data"].map((x) => AktivitasPetugas.fromJson(x))),
      );
}

class AktivitasPetugas {
  AktivitasPetugas({
    required this.id,
    required this.jadwalId,
    required this.petugasId,
    required this.date,
    required this.time,
    required this.photo,
    required this.feedback,
    required this.createdAt,
    required this.updatedAt,
    required this.jadwal,
  });

  int? id;
  String? jadwalId;
  String? petugasId;
  DateTime? date;
  DateTime? time;
  String? photo;
  String? feedback;
  DateTime? createdAt;
  DateTime? updatedAt;
  Jadwal? jadwal;

  factory AktivitasPetugas.fromJson(Map<String, dynamic> json) =>
      AktivitasPetugas(
        id: json["id"],
        jadwalId: json["jadwal_id"],
        petugasId: json["petugas_id"],
        date: DateTime.parse(json["date"]),
        time: DateTime.parse(json["time"]),
        photo: json["photo"],
        feedback: json["feedback"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        jadwal: Jadwal.fromJson(json["jadwal"]),
      );
}

class Jadwal {
  Jadwal({
    required this.id,
    required this.userId,
    required this.petugasId,
    required this.code,
    required this.cleanArea,
    required this.keterangan,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int? id;
  String? userId;
  String? petugasId;
  String? code;
  String? cleanArea;
  String? keterangan;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  User user;

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        id: json["id"],
        userId: json["user_id"],
        petugasId: json["petugas_id"],
        code: json["code"],
        cleanArea: json["clean_area"],
        keterangan: json["keterangan"],
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
  dynamic address;
  dynamic phone;
  String email;
  dynamic emailVerifiedAt;
  String password;
  dynamic rememberToken;
  dynamic photo;
  DateTime createdAt;
  DateTime updatedAt;

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
        photo: json["photo"],
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
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
