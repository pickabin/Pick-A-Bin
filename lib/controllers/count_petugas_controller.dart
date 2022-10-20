import 'package:boilerplate/models/count_petugas.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CountPetugasController{
  //get count petugas https://azdevweb.online/api/koorGedung/getStatusPetugas/$id
  Future<CountPetugas?> getStatusPetugas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id= prefs.getInt('user_id').toString();
    final response = await http.get(Uri.parse('https://azdevweb.online/api/koorGedung/getStatusPetugas/$id'));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      CountPetugasResult countPetugasResult = countPetugasFromJson(response.body);
      CountPetugas? countPetugas = countPetugasResult.data;
      return countPetugas;
    } else {
      throw Exception('Failed to load data');
    }
  }
}