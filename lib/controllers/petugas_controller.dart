import 'package:boilerplate/models/cek_code.dart';
import 'package:boilerplate/models/petugas.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PetugasController {

  String? dataCode;
  var data = [];
  List<Petugas> searchResult = [];

  Future<List<Petugas>> getPetugas() async {
    //get code
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString('code');
    final response =
        await http.get(Uri.parse('https://azdevweb.online/api/petugas/$code'));
    if (response.statusCode == 200) {
      PetugasResult petugasResult = petugasFromJson(response.body);
      List<Petugas> petugas = petugasResult.data;
      return petugas;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //search petugas
  Future<List<Petugas>> searchPetugas({String? query}) async {
    //get code
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString('code');
    try {
      final response = await http
          .get(Uri.parse('https://azdevweb.online/api/petugas/$code'));
      if (response.statusCode == 200) {
        data = json.decode(response.body)['data'];
        searchResult = data.map((e) => Petugas.fromJson(e)).toList();
        if (query != null) {
          searchResult = searchResult
              .where((element) => element.user!.name!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
        } else {
          print('Fetch Error');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }

    return searchResult;
  }

  Future<List<Petugas>> getPetugasByUid() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? uid = prefs.getString('uid');
      final response = await http.get(Uri.parse(
          'https://azdevweb.online/api/petugas/getPetugasByUid/' +
              uid.toString()));
      if (response.statusCode == 200) {
        PetugasResult petugasResult = petugasFromJson(response.body);
        List<Petugas> petugas = petugasResult.data;
        return petugas;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  //get petugas code
  Future<String?> getPetugasCode() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? uid = prefs.getString('uid');
      final response = await http.get(Uri.parse(
          'https://azdevweb.online/api/petugas/getPetugasByUid/' +
              uid.toString()));
      if (response.statusCode == 200) {
        PetugasResult petugasResult = petugasFromJson(response.body);
        //get data from json
        List<Petugas> petugas = petugasResult.data;
        petugas.forEach((element) {
          print("ini kode" + element.code.toString());
          this.dataCode = element.code;
        });
        return dataCode;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<http.Response> addPetugas(String uid) async {
    return http.post(
      Uri.parse('https://azdevweb.online/api/petugas/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': uid,
      }),
    );
  }

  //update image
  static Future<http.Response> updateImage(int? id, String? image) async {
    return http.put(
      Uri.parse('https://azdevweb.online/api/petugas/update/' + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'photo': image != null ? image : '',
      }),
    );
  }

   // get data cek code from api
  Future<String> getCekCode(String code) async {
    print("ini code " + code);
    final response = await http.get(Uri.parse('https://azdevweb.online/api/petugas/cekCode/$code'));
    if (response.statusCode == 200) {
      CekCode cekCodeResult = cekCodeFromJson(response.body);
      int? cekCode = cekCodeResult.data;
      return cekCode.toString();
    } else {
      throw Exception('Failed to load data');
    }
  }

}
