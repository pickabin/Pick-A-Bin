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

  static Future<http.Response> addAspirasi(int id,String judul, String isi) async {
    return http.post(
      Uri.parse('https://azdevweb.online/api/aspirasi/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': id.toString(),
        'title': judul.toString(),
        'description': isi.toString(),
        'created_at': DateTime.now().toString(),
        'updated_at': DateTime.now().toString(),
      }),
    );
  }
}
