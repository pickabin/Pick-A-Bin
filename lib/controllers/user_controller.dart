import 'dart:convert';
import 'package:boilerplate/models/user_data.dart';
import 'package:http/http.dart' as http;
import '../models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  Future<List<UserData>> getUser() async {
    final response =
        await http.get(Uri.parse('https://azdevweb.online/api/user'));
    if (response.statusCode == 200) {
      UserDataResult userResult = userFromJson(response.body);
      List<UserData> user = userResult.data;
      return user;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<UserData>> getUserUid() async {
    //get value uid from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    try {
      final response = await http.get(
          Uri.parse('https://azdevweb.online/api/user/uid/' + uid.toString()));
      if (response.statusCode == 200) {
        UserDataResult userResult = userFromJson(response.body);
        List<UserData> user = userResult.data;
        return user;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<http.Response> addUser(
      String uid, String name, String email, String password) async {
    return http.post(
      Uri.parse('https://azdevweb.online/api/user/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': uid,
        'name': name,
        'email': email,
        'password': password,
      }),
    );
  }

  static Future<http.Response> updateUser(
      int? id, String name, String address, String phone) async {
    return http.put(
      Uri.parse('https://azdevweb.online/api/user/update/' + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'address': address,
        'phone': phone,
      }),
    );
  }

  //update image
  static Future<http.Response> updateImage(int? id, String? image) async {
    return http.put(
      Uri.parse('https://azdevweb.online/api/user/update/' + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'image_url': image != null ? image : '',
      }),
    );
  }
  
}
