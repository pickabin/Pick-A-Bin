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

  static Future<AktivitasKoor?> addProduct(AktivitasKoor aktivitasKoor) async {
    final response = await http.post(
      Uri.parse('https://azdevweb.online/api/aktivitasKoor'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
       'jadwal_id': aktivitasKoor.jadwalId,
        'date': aktivitasKoor.date.toString(),
        'time': aktivitasKoor.time,
        'photo': aktivitasKoor.photo,
        'created_at': aktivitasKoor.createdAt.toString(),
        'updated_at': aktivitasKoor.updatedAt.toString(),
      },
    ); 
    final data = json.decode(response.body);

    return AktivitasKoor(
      id: data['data']['id'],
      jadwalId: data['data']['jadwal_id'],
      date: data['data']['date'],
      time: data['data']['time'],
      photo: data['data']['photo'],
      createdAt: data['data']['created_at'],
      updatedAt: data['data']['updated_at'],
    );
  }
}