import 'dart:convert';

CountPetugasResult countPetugasFromJson(String str) => CountPetugasResult.fromJson(json.decode(str));
class CountPetugasResult {
  CountPetugasResult({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final String? message;
  final CountPetugas? data;

  factory CountPetugasResult.fromJson(Map<String, dynamic> json) {
    return CountPetugasResult(
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? null : CountPetugas.fromJson(json["data"]),
    );
  }

}

class CountPetugas {
  CountPetugas({
    required this.petugas,
    required this.listDone,
  });

  final int? petugas;
  final int? listDone;

  factory CountPetugas.fromJson(Map<String, dynamic> json) {
    return CountPetugas(
      petugas: json["petugas"],
      listDone: json["listDone"],
    );
  }

}
