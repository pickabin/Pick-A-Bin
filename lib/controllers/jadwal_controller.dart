import 'package:boilerplate/models/jadwal.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JadwalController {
  //get data dari jadwal dengan mengirimkan id dari user yang login
  Future<List<Jadwal>> getJadwal() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getInt('user_id').toString();
      print("Ini user id : " + id);
      final response =
          await http.get(Uri.parse('https://azdevweb.online/api/jadwal/$id'));
      if (response.statusCode == 200) {
        JadwalResult jadwalResult = jadwalFromJson(response.body);
        List<Jadwal> jadwal = jadwalResult.data;
        return jadwal;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  //get all data jadwal
  Future<List<Jadwal>> getAllJadwal() async {
    final response =
        await http.get(Uri.parse('https://azdevweb.online/api/jadwal'));
    if (response.statusCode == 200) {
      JadwalResult jadwalResult = jadwalFromJson(response.body);
      List<Jadwal> jadwal = jadwalResult.data;
      return jadwal;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // static Future<Jadwal?> addProduct(Jadwal jadwal) async {
  //   final response = await http.post(
  //     Uri.parse('https://azdevweb.online/api/jadwal'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: {
  //       'uid' : jadwal.id,
  //       'clean_area' : jadwal.cleanArea,
  //       'created_at' : jadwal.createdAt.toString(),
  //       'updated_at' : jadwal.updatedAt.toString(),
  //     },
  //   );
  //   final data = json.decode(response.body);

  //   return Jadwal(
  //     id: data['data']['id'],
  //     uid: data['data']['user_id'],
  //     cleanArea: data['data']['clean_area'],
  //     createdAt: data['data']['created_at'],
  //     updatedAt: data['data']['updated_at'],
  //   );
  // }

  //update jadwal
  static Future<http.Response> updateJadwal(String photo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('user_id').toString();
    String petugasId = prefs.getInt('petugas_id').toString();
    String koorId = prefs.getInt('koor_id').toString();
    print("Ini koor id : " + koorId);
    return http.put(
      Uri.parse('https://azdevweb.online/api/jadwal/update/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'koor_gedung_id': koorId,
        'petugas_id': petugasId,
        'photo': photo.toString(),
      }),
    );
  }

  //update and get jadwal petugas
  static Future<http.Response> updateJadwalPetugas(
      String code, String cleanArea) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('user_id').toString();
    return http.post(
      Uri.parse('https://azdevweb.online/api/petugas/update/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'code': code.toString(),
        'clean_area': cleanArea.toString(),
      }),
    );
  }

  static Future<http.Response> updateJadwalKoor(
      String code, String cleanArea) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('user_id').toString();
    return http.post(
      Uri.parse('https://azdevweb.online/api/koorGedung/update/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'code': code.toString(),
        'clean_area': cleanArea.toString(),
      }),
    );
  }

  //update code dan clean area petugas
  static Future<http.Response> updateCodeCleanPetugas(
      String code, String cleanArea) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('user_id').toString();
    return http.put(
      Uri.parse('https://azdevweb.online/api/petugas/updateCode/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'code': code.toString(),
        'clean_area': cleanArea.toString(),
      }),
    );
  }

  //update code dan clean area koor
  static Future<http.Response> updateCodeCleanKoor(
      String code, String cleanArea) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('user_id').toString();
    return http.put(
      Uri.parse('https://azdevweb.online/api/koorGedung/updateCode/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'code': code.toString(),
        'clean_area': cleanArea.toString(),
      }),
    );
  }
}
