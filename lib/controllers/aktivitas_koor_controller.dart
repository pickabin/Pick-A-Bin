import 'dart:convert';
import 'package:boilerplate/models/aktivitas_koor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AktivitasKoorController{
  Future<List<AktivitasKoor>> getAktivitasKoor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getInt('user_id').toString();
    final response = await http.get(Uri.parse('https://azdevweb.online/api/aktivitasKoor/$id'));
    if (response.statusCode == 200) {
      AktivitasKoorResult aktivitasKoorResult = aktivitasKoorFromJson(response.body);
      List<AktivitasKoor> aktivitasKoor = aktivitasKoorResult.data;
      return aktivitasKoor;
    } else {
      throw Exception('Failed to load data');
    }
  }


}