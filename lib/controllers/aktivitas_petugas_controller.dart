import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:boilerplate/models/aktivitas_petugas.dart';

class AktivitasPetugasController{
  Future<List<AktivitasPetugas>> getAktivitasPetugas() async {
    final response = await http.get(Uri.parse('https://azdevweb.online/api/aktivitasPetugas'));
    if (response.statusCode == 200) {
      AktivitasPetugasResult aktivitasPetugasResult = aktivitasPetugasFromJson(response.body);
      List<AktivitasPetugas> aktivitasPetugas = aktivitasPetugasResult.data;
      return aktivitasPetugas;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<http.Response> addPetugas(
      int jadwalId, DateTime date, DateTime time, String photo) async {
    return http.post(
      Uri.parse('https://azdevweb.online/api/user/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'jadwal_id': jadwalId.toString(),
        'date': date.toString(),
        'time': time.toString(),
        'photo': photo,
      }),
    );
  }
}