import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:boilerplate/models/aspirasi.dart';

class AspirasiController {
  Future<List<Aspirasi>> getAspirasi() async {
    final response =
        await http.get(Uri.parse('https://azdevweb.online/api/aspirasi'));
    if (response.statusCode == 200) {
      AspirasiResult aspirasiResult = aspirasiFromJson(response.body);
      List<Aspirasi> aspirasi = aspirasiResult.data;
      return aspirasi;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Aspirasi?> addProduct(Aspirasi aspirasi) async {
    final response = await http.post(
      Uri.parse('https://azdevweb.online/api/aspirasi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        'uid': aspirasi.uid,
        'title': aspirasi.title,
        'description': aspirasi.description,
        'created_at': aspirasi.createdAt.toString(),
        'updated_at': aspirasi.updatedAt.toString(),
      },
    );
    final data = json.decode(response.body);

    return Aspirasi(
      id: data['data']['id'],
      uid: data['data']['user_id'],
      title: data['data']['title'],
      description: data['data']['description'],
      createdAt: data['data']['created_at'],
      updatedAt: data['data']['updated_at'],
    );
  }
}
