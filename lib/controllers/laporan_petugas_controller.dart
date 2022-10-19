import 'package:boilerplate/models/laporan_petugas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LaporanPetugasController{
   //get Aktivitas petugas by code
  Future<List<LaporanPetugas>> getAktivitasPetugasByCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString('code').toString();
    final response = await http.get(Uri.parse('https://azdevweb.online/api/aktivitasPetugas/byCode/$code'));
    if (response.statusCode == 200) {
      LaporanPetugasResult laporanPetugasResult = laporanPetugasFromJson(response.body);
      List<LaporanPetugas> laporanPetugas = laporanPetugasResult.data;
      return laporanPetugas;
    } else {
      throw Exception('Failed to load data');
    }
  }
}