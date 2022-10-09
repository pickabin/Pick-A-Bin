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

  static Future<Jadwal?> addProduct(Jadwal jadwal) async {
    final response = await http.post(
      Uri.parse('https://azdevweb.online/api/jadwal'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        'uid' : jadwal.uid,
        'clean_area' : jadwal.cleanArea,
        'created_at' : jadwal.createdAt.toString(),
        'updated_at' : jadwal.updatedAt.toString(),
      },
    );
    final data = json.decode(response.body);

    return Jadwal(
      id: data['data']['id'],
      uid: data['data']['user_id'],
      cleanArea: data['data']['clean_area'],
      createdAt: data['data']['created_at'],
      updatedAt: data['data']['updated_at'],
    );
  }
}