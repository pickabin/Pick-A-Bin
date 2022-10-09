import 'package:boilerplate/models/jadwal.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JadwalController{
  Future<List<Jadwal>> getJadwal() async {
    final response = await http.get(Uri.parse('https://azdevweb.online/api/jadwal'));
    if (response.statusCode == 200) {
      JadwalResult jadwalResult = jadwalFromJson(response.body);
      List<Jadwal> jadwal = jadwalResult.data;
      return jadwal;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<http.Response> addJadwal(
      int userId, String cleanArea, bool status) async {
        return http.post(
          Uri.parse('https://azdevweb.online/api/user/store'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'user_id' : userId.toString(),
            'clean_area' : cleanArea,
            'status' : status.toString(),
          }),
        );
  }
}