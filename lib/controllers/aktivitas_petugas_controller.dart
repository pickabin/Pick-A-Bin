import 'package:http/http.dart' as http;
import 'package:boilerplate/models/aktivitas_petugas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AktivitasPetugasController{
  Future<List<AktivitasPetugas>> getAktivitasPetugas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('user_id').toString();
    final response = await http.get(Uri.parse('https://azdevweb.online/api/aktivitasPetugas/$id'));
    if (response.statusCode == 200) {
      AktivitasPetugasResult aktivitasPetugasResult = aktivitasPetugasFromJson(response.body);
      List<AktivitasPetugas> aktivitasPetugas = aktivitasPetugasResult.data;
      return aktivitasPetugas;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //delete
  static Future<http.Response> deleteAktivitasPetugas(int? id) async {
    return http.delete(
      Uri.parse('https://azdevweb.online/api/aktivitasPetugas/destroy/' + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

}