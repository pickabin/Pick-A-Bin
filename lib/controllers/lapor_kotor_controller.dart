import 'dart:convert';
import 'package:boilerplate/models/lapor_kotor.dart';
import 'package:http/http.dart' as http;

class LaporKotorController{
  Future<List<LaporKotor>> getLaporKotor() async {
    final response = await http.get(Uri.parse('https://azdevweb.online/api/laporKotor'));
    if (response.statusCode == 200) {
      LaporKotorResult laporKotorResult = laporKotorFromJson(response.body);
      List<LaporKotor> laporKotor = laporKotorResult.data;
      return laporKotor;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<LaporKotor?> addProduct(LaporKotor laporKotor) async {
    final response = await http.post(
      Uri.parse('https://azdevweb.online/api/laporKotor'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        'koorCode' : laporKotor.koorCode,
        'cleanArea' : laporKotor.cleanArea,
        'photo' : laporKotor.photo,
        'created_at' : laporKotor.createdAt.toString(),
        'updated_at' : laporKotor.updatedAt.toString(),
      },
    ); 
    final data = json.decode(response.body);

    return LaporKotor(
      id: data['data']['id'],
      koorCode: data['data']['koor_code'],
      cleanArea: data['data']['clean_area'],
      photo: data['data']['photo'],
      createdAt: data['data']['created_at'],
      updatedAt: data['data']['updated_at'],
    );
  }
}