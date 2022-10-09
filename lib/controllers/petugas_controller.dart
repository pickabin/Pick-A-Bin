import 'package:boilerplate/models/petugas.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PetugasController{
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


  static Future<http.Response> addPetugas(
      int userId, String code, String cleanArea, String photo) async {
    return http.post(
      Uri.parse('https://azdevweb.online/api/user/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId.toString(),
        'code' : code,
        'clean_area' : cleanArea,
        'photo' : photo,
      }),
    );
  }
}