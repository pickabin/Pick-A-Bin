import 'package:boilerplate/models/koor_gedung.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class KoorGedungController{
  Future<List<KoorGedung>> getKoorGedung() async {
    final response = await http.get(Uri.parse('https://azdevweb.online/api/koor_gedung'));
    if (response.statusCode == 200) {
      KoorGedungResult koorGedungResult = koorGedungFromJson(response.body);
      List<KoorGedung> koorGedung = koorGedungResult.data;
      return koorGedung;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<KoorGedung?> addUser(KoorGedung koorGedung, String email, String password) async {
    final response = await http.post(
      Uri.parse('https://azdevweb.online/api/koor_gedung'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        'user_id': koorGedung.userId,
        'code' : koorGedung.code,
        'clean_area' : koorGedung.cleanArea,
        'photo' : koorGedung.photo,
        'created_at' : koorGedung.createdAt.toString(),
        'updated_at' : koorGedung.updatedAt.toString(),
      },
    );
    final data = json.decode(response.body);

    return KoorGedung(
      id: data['data']['id'],
      userId: data['data']['user_id'],
      code: data['data']['code'],
      cleanArea: data['data']['clean_area'],
      photo: data['data']['photo'],
      createdAt: data['data']['created_at'],
      updatedAt: data['data']['updated_at'],
    );
  }
}