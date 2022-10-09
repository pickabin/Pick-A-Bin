import 'dart:convert';
import 'package:boilerplate/models/aktivitas_koor.dart';
import 'package:http/http.dart' as http;

class AktivitasKoorController{
  Future<List<AktivitasKoor>> getAktivitasKoor() async {
    final response = await http.get(Uri.parse('https://azdevweb.online/api/aktivitasKoor'));
    if (response.statusCode == 200) {
      AktivitasKoorResult aktivitasKoorResult = aktivitasKoorFromJson(response.body);
      List<AktivitasKoor> aktivitasKoor = aktivitasKoorResult.data;
      return aktivitasKoor;
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