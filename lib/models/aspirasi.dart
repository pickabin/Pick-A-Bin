import 'dart:convert';

AspirasiResult aspirasiFromJson(String str) => AspirasiResult.fromJson(json.decode(str));

class AspirasiResult {
    AspirasiResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<Aspirasi> data;

    factory AspirasiResult.fromJson(Map<String, dynamic> json) => AspirasiResult(
        code: json["code"],
        message: json["message"],
        data: List<Aspirasi>.from(json["data"].map((x) => Aspirasi.fromJson(x))),
    );
}

class Aspirasi {
    Aspirasi({
        required this.id,
        required this.uid,
        required this.title,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String? uid;
    String? title;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Aspirasi.fromJson(Map<String, dynamic> json) => Aspirasi(
       id: json["id"],
        uid: json["uid"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}