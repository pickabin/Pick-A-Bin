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
        'uid': koorGedung.uid,
        'name' : koorGedung.name,
        'address' : koorGedung.address,
        'phone' : koorGedung.phone,
        'code' : koorGedung.code,
        'email' : koorGedung.email,
        'photo' : koorGedung.photo,
        'created_at' : koorGedung.createdAt.toString(),
        'updated_at' : koorGedung.updatedAt.toString(),
      },
    );
    final data = json.decode(response.body);

    return KoorGedung(
      id: data['data']['id'],
      uid: data['data']['user_id'],
      name: data['data']['name'],
      address: data['data']['address'],
      phone: data['data']['phone'],
      code: data['data']['code'],
      email: data['data']['email'],
      photo: data['data']['photo'],
      createdAt: data['data']['created_at'],
      updatedAt: data['data']['updated_at'],
    );
  }
}