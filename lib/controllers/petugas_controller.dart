import 'package:boilerplate/models/petugas.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PetugasController{
  String? dataCode;
  Future<List<Petugas>> getPetugas() async {
    final response = await http.get(Uri.parse('https://azdevweb.online/api/petugas/'));
    if (response.statusCode == 200) {
      PetugasResult petugasResult = petugasFromJson(response.body);
      List<Petugas> petugas = petugasResult.data;
      return petugas;
    } else {
      throw Exception('Failed to load data');
    }
  }
  
  Future<List<Petugas>> getPetugasByUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    final response = await http.get(Uri.parse('https://azdevweb.online/api/petugas/getPetugasByUid/' + uid.toString()));
    if (response.statusCode == 200) {
      PetugasResult petugasResult = petugasFromJson(response.body);
      List<Petugas> petugas = petugasResult.data;
      return petugas;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //get petugas code
  Future<String?> getPetugasCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    final response = await http.get(Uri.parse('https://azdevweb.online/api/petugas/getPetugasByUid/' + uid.toString()));
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
  }

  // Future<List<UserData>> getPetugas() async {
  //   final response = await http.get(Uri.parse('https://azdevweb.online/api/petugas/'));
  //   if (response.statusCode == 200) {
  //     PetugasResult petugasResult = petugasFromJson(response.body);
  //     List<Petugas> petugas = petugasResult.data;
  //     List<UserData> user;
  //     for(int i = 0; i < petugas.length; i++){
  //       final response = await http.get(Uri.parse('https://azdevweb.online/api/petugas/getUser/' + petugas[i].userId));
  //       if(response.statusCode == 200){
  //         UserDataResult userDataResult = userFromJson(response.body);
  //         print(userDataResult.data);
  //         // user = userDataResult.data;
  //       }else{
  //         throw Exception('Failed to load data');
  //       }
  //     }
  //     return user;
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }


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


}