import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Directions {
  final LatLngBounds? bounds;
  final List<PointLatLng>? polylinePoints;
  final String? totalDistance;
  final String? totalDuration;

  const Directions({
     @required this.bounds,
     @required this.polylinePoints,
     @required this.totalDistance,
     @required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) {
      return Directions(
        bounds: null,
        polylinePoints: null,
        totalDistance: null,
        totalDuration: null,
      );
    }

    final data = Map<String, dynamic>.from(map['routes'][0]);
     
    //bounds
    final northeastLat = data['bounds']['northeast'];
    final southwestLat = data['bounds']['southwest']; 
    final bounds = LatLngBounds(
      northeast: LatLng(northeastLat['lat'], northeastLat['lng']),
      southwest: LatLng(southwestLat['lat'], southwestLat['lng']),
    );

    String distance = "";
    String duration = "";
    if((data['legs'] as List).isEmpty){
      final legs = data['legs'][0];
      distance = legs['distance']['text'];
      duration = legs['duration']['text'];
    }

    return Directions(
      bounds: bounds,
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
