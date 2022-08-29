import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsDistributionPage extends StatefulWidget {
  const MapsDistributionPage({Key? key}) : super(key: key);

  @override
  State<MapsDistributionPage> createState() => _MapsDistributionPageState();
}

class _MapsDistributionPageState extends State<MapsDistributionPage> {
  final _pageOptionsMaps = [MapsDistributionPage()];

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // Indonesia marker
  static final Marker markerLocation = Marker(
    markerId: MarkerId('myMarker'),
    position: LatLng(-6.17511, 106.82798),
    infoWindow: InfoWindow(
      title: 'Indonesia',
      snippet: 'This is Indonesia',
    ),
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-6.17511, 106.82798),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Peta Persebaran',
          style: TextStyle(color: Colors.green),
        ),
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: GoogleMap(
        markers: {markerLocation},
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            //first calling is false
            //call "completer()"
            _controller.complete(controller);
          } else {
            //other calling, later is true,
            //don't call again completer()
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
       floatingActionButton: FloatingActionButton(
        onPressed: _goToTheLake,
        backgroundColor: Colors.green,
        child: Icon(Icons.location_on),
      ),
    );
  }
   Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
