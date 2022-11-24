import 'dart:convert';
import 'package:boilerplate/models/koor_gedung.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class KoorGedungController {

  String? dataCode;
  var data = [];
  List<KoorGedung> searchResult = [];

  Future<List<KoorGedung>> getKoorGedung() async {
    final response =
        await http.get(Uri.parse('https://azdevweb.online/api/koorGedung/'));
    if (response.statusCode == 200) {
      KoorGedungResult koorGedungResult = koorGedungFromJson(response.body);
      List<KoorGedung> koorGedung = koorGedungResult.data;
      return koorGedung;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //search koorGedung
  Future<List<KoorGedung>> searchKoorGedung({String? query}) async {
    try {
      final response =
          await http.get(Uri.parse('https://azdevweb.online/api/koorGedung/'));
      if (response.statusCode == 200) {
        data = json.decode(response.body)['data'];
        searchResult = data.map((e) => KoorGedung.fromJson(e)).toList();
        if (query != null) {
          searchResult = searchResult
              .where((element) => element.user.name!
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

  Future<List<KoorGedung>> getKoorByUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    try {
      final response = await http.get(Uri.parse(
          'https://azdevweb.online/api/koorGedung/getKoorByUid/' +
              uid.toString()));
      if (response.statusCode == 200) {
        KoorGedungResult koorGedungResult = koorGedungFromJson(response.body);
        List<KoorGedung> koorGedung = koorGedungResult.data;
        return koorGedung;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return [];
    }
  }

  Future<String?> getKoorGedungCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    final response = await http.get(Uri.parse(
        'https://azdevweb.online/api/koorGedung/getKoorByUid/' +
            uid.toString()));
    if (response.statusCode == 200) {
      KoorGedungResult koorGedungResult = koorGedungFromJson(response.body);
      //get data from json
      List<KoorGedung> koorGedung = koorGedungResult.data;
      koorGedung.forEach((element) {
        print("ini kode" + element.code.toString());
        this.dataCode = element.code;
      });
      return dataCode;
    } else {
      throw Exception('Failed to load data');
    }
  }


  static Future<http.Response> addKoorGedung(String uid) async {
    return http.post(
      Uri.parse('https://azdevweb.online/api/koorGedung/store'),
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
      Uri.parse(
          'https://azdevweb.online/api/koorGedung/update/' + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'photo': image != null ? image : '',
      }),
    );
  }
}
