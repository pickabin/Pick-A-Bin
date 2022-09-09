import 'dart:async';
import 'package:boilerplate/data/repository/maps_utils.dart';
import 'package:boilerplate/models/maps/directions_model.dart';
import 'package:boilerplate/ui/maps/detail_location_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsDistributionPage extends StatefulWidget {
  const MapsDistributionPage({Key? key}) : super(key: key);

  @override
  State<MapsDistributionPage> createState() => _MapsDistributionPageState();
}

class _MapsDistributionPageState extends State<MapsDistributionPage> {
  final pageOptionsMaps = [MapsDistributionPage()];

  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;

  // detailLocation(LatLng latLng) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(20), topLeft: Radius.circular(20))),
  //     backgroundColor: Colors.white,
  //     context: context,
  //     builder: (_) {
  //       return FractionallySizedBox(
  //         heightFactor: 0.8,
  //         child: DetailLocationPage(),
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    // _googleMapController!.dispose();
    super.dispose();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-6.17511, 106.82598),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    final List<Marker> _list = [
      Marker(
          markerId: MarkerId('myMarker'),
          position: LatLng(-6.17511, 106.82698),
          infoWindow: InfoWindow(
              title: 'Jakarta',
              snippet: 'This is Jakarta',
              onTap: () {
                MapsUtils.openMap(-6.17511, 106.82700);
              }),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              backgroundColor: Colors.white,
              context: context,
              builder: (_) {
                return FractionallySizedBox(
                  heightFactor: 0.6,
                  child: DetailLocationPage(lat: -6.17511, long: 106.82698),
                );
              },
            );
          }),
      Marker(
          markerId: MarkerId('myMarker'),
          position: LatLng(-7.250445, 112.768845),
          infoWindow: InfoWindow(
              title: 'Surabaya',
              snippet: 'This is Surabaya',
              onTap: () {
                MapsUtils.openMap(-7.250445, 112.768845);
              }),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              backgroundColor: Colors.white,
              context: context,
              builder: (_) {
                return FractionallySizedBox(
                  heightFactor: 0.6,
                  child: DetailLocationPage(lat: -7.250445, long: 112.768845),
                );
              },
            );
          }),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Google Maps',
          style: TextStyle(color: Colors.green),
        ),
        iconTheme: IconThemeData(color: Colors.green),
        actions: [
          TextButton(
            onPressed: () => _googleMapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(-6.17511, 106.82598),
                  zoom: 14.4746,
                  tilt: 50,
                ),
              ),
            ),
            style: TextButton.styleFrom(
              primary: Colors.green,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('ORIGIN'),
          ),
          TextButton(
            onPressed: () => _googleMapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(-6.17511, 106.82698),
                  zoom: 14.4746,
                  tilt: 50.0,
                ),
              ),
            ),
            style: TextButton.styleFrom(
              primary: Colors.green,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('DESTINATION'),
          )
        ],
      ),
      body: Stack(alignment: Alignment.center, children: [
        GoogleMap(
          markers: Set.from(_list),
          polylines: {
            if (_info != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Colors.red,
                width: 5,
                points: _info!.polylinePoints!
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
          mapType: MapType.normal,
          initialCameraPosition: _kLake,
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
        if (_info != null)
          Positioned(
            top: 20,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '${_info!.totalDistance.toString()} - ${_info!.totalDuration.toString()}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // MapsUtils.openMap(47.62829,43.1242)
          _goToTheLake()
        },
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
