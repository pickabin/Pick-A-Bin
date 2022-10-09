import 'package:boilerplate/models/petugas.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PetugasController{
  Future<List<Petugas>> getPetugas() async {
    final response = await http.get(Uri.parse('https://azdevweb.online/api/petugas'));
    if (response.statusCode == 200) {
      PetugasResult petugasResult = petugasFromJson(response.body);
      List<Petugas> petugas = petugasResult.data;
      return petugas;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Petugas?> addProduct(Petugas petugas) async {
    final response = await http.post(
      Uri.parse('https://azdevweb.online/api/petugas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
        'uid': petugas.uid,
        'koorCode': petugas.koorCode,
        'cleanArea' : petugas.cleanArea,
        'name' : petugas.name,
        'address' : petugas.address,
        'phone' : petugas.phone,
        'email' : petugas.email,
        'photo' : petugas.photo,
        'created_at' : petugas.createdAt.toString(),
        'updated_at' : petugas.updatedAt.toString(),
      },
    );
    final data = json.decode(response.body);

    return Petugas(
      id: data['data']['id'],
      uid: data['data']['user_id'],
      koorCode: data['data']['koor_code'],
      cleanArea: data['data']['clean_area'],
      name: data['data']['name'],
      address: data['data']['address'],
      phone: data['data']['phone'],
      email: data['data']['email'],
      photo: data['data']['photo'],
      createdAt: data['data']['created_at'],
      updatedAt: data['data']['updated_at'],
    );
  }
}