import 'dart:convert';


UserDataResult userFromJson(String str) => UserDataResult.fromJson(json.decode(str));


class UserDataResult {
    UserDataResult({
        required this.code,
        required this.message,
        required this.data,
    });

    int code;
    String message;
    List<UserData> data;

    factory UserDataResult.fromJson(Map<String, dynamic> json) => UserDataResult(
        code: json["code"],
        message: json["message"],
        data: List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
    );
}

class UserData {
    UserData({
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
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
