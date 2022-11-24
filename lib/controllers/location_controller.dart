import 'dart:convert';

import 'package:boilerplate/data/service/location_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;


class LocationController extends GetxController{

  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _pickPlacemark;
  
  List<Prediction> _predictionsList = [];

  Future<List<Prediction>?> searchLocation(BuildContext context, String text) async{
    if(text.isNotEmpty){
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      print("My Status is: " + data['status'].toString());
      if(data['status'] == 'Ok'){
        _predictionsList = [];
        data['predictions'].forEach((prediction)=> _predictionsList.add(Prediction.fromJson(prediction)));
      }else{

      }     
    }
     return _predictionsList;
  }
}