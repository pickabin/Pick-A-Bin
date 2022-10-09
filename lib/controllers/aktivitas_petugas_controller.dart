import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:boilerplate/models/aktivitas_petugas.dart';

class AktivitasPetugasController{
  Future<List<AktivitasPetugas>> getAktivitasPetugas() async {
    final response = await http.get(Uri.parse('https://azdevweb.online/api/aktivitasPetugas'));
    if (response.statusCode == 200) {
      AktivitasPetugasResult aktivitasPetugasResult = aktivitasPetugasFromJson(response.body);
      List<AktivitasPetugas> aktivitasPetugas = aktivitasPetugasResult.data;
      return aktivitasPetugas;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<AktivitasPetugas?> addProduct(AktivitasPetugas aktivitasPetugas) async {
    final response = await http.post(
      Uri.parse('https://azdevweb.online/api/aktivitasPetugas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {
       'jadwal_id': aktivitasPetugas.jadwalId,
        'date': aktivitasPetugas.date.toString(),
        'time': aktivitasPetugas.time,
        'photo': aktivitasPetugas.photo,
        'created_at': aktivitasPetugas.createdAt.toString(),
        'updated_at': aktivitasPetugas.updatedAt.toString(),
      },
    ); 
    final data = json.decode(response.body);

    return AktivitasPetugas(
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