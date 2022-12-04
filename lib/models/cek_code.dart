import 'dart:convert';

CekCode cekCodeFromJson(String str) => CekCode.fromJson(json.decode(str));

class CekCode {
    CekCode({
       required this.code,
       required this.message,
       required this.data,
    });

    int? code;
    String? message;
    int? data;

    factory CekCode.fromJson(Map<String, dynamic> json) => CekCode(
        code: json["code"],
        message: json["message"],
        data: json["data"],
    );

}
