import 'dart:convert';
import 'package:boilerplate/models/koor_gedung.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class KoorGedungController{
  String? dataCode;
  Future<List<KoorGedung>> getKoorGedung() async {
    final response = await http.get(Uri.parse('https://azdevweb.online/api/koorGedung/'));
    if (response.statusCode == 200) {
      KoorGedungResult koorGedungResult = koorGedungFromJson(response.body);
      List<KoorGedung> koorGedung = koorGedungResult.data;
      return koorGedung;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<KoorGedung>> getKoorByUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    final response = await http.get(Uri.parse('https://azdevweb.online/api/koorGedung/getKoorByUid/' + uid.toString()));
    if (response.statusCode == 200) {
      KoorGedungResult koorGedungResult = koorGedungFromJson(response.body);
      List<KoorGedung> koorGedung = koorGedungResult.data;
      return koorGedung;
    } else {
      throw Exception('Failed to load data');
    }
  }

   Future<String?> getKoorGedungCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    final response = await http.get(Uri.parse('https://azdevweb.online/api/koorGedung/getKoorByUid/' + uid.toString()));
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

  // static Future<KoorGedung?> addUser(KoorGedung koorGedung, String email, String password) async {
  //   final response = await http.post(
  //     Uri.parse('https://azdevweb.online/api/koor_gedung'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: {
  //       'uid': koorGedung.uid,
  //       'name' : koorGedung.name,
  //       'address' : koorGedung.address,
  //       'phone' : koorGedung.phone,
  //       'code' : koorGedung.code,
  //       'email' : koorGedung.email,
  //       'photo' : koorGedung.photo,
  //       'created_at' : koorGedung.createdAt.toString(),
  //       'updated_at' : koorGedung.updatedAt.toString(),
  //     },
  //   );
  //   final data = json.decode(response.body);

  //   return KoorGedung(
  //     id: data['data']['id'],
  //     uid: data['data']['user_id'],
  //     name: data['data']['name'],
  //     address: data['data']['address'],
  //     phone: data['data']['phone'],
  //     code: data['data']['code'],
  //     email: data['data']['email'],
  //     photo: data['data']['photo'],
  //     createdAt: data['data']['created_at'],
  //     updatedAt: data['data']['updated_at'],
  //   );
  // }

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
      Uri.parse('https://azdevweb.online/api/koorGedung/update/' + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'photo': image != null ? image : '',
      }),
    );
  }

  
}