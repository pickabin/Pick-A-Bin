// To parse this JSON data, do
//
//     final LaporAcaraResult = LaporAcaraFromJson(jsonString);

import 'dart:convert';

LaporAcaraResult laporAcaraFromJson(String str) =>
    LaporAcaraResult.fromJson(json.decode(str));

class LaporAcaraResult {
  LaporAcaraResult({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<LaporAcara> data;

  factory LaporAcaraResult.fromJson(Map<String, dynamic> json) =>
      LaporAcaraResult(
        code: json["code"],
        message: json["message"],
        data: List<LaporAcara>.from(
            json["data"].map((x) => LaporAcara.fromJson(x))),
      );
}

class LaporAcara {
  LaporAcara({
    required this.id,
    required this.code,
    required this.tempat,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? code;
  String? tempat;
  String? title;
  String? description;
  DateTime? date;
  DateTime? time;
  String? status;
  dynamic? createdAt;
  dynamic? updatedAt;

  factory LaporAcara.fromJson(Map<String, dynamic> json) => LaporAcara(
        id: json["id"],
        code: json["code"],
        tempat: json["tempat"],
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        time: DateTime.parse(json["time"]),
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
