import 'package:boilerplate/ui/home/detail_acara.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class PickPointAcara extends StatefulWidget {
  const PickPointAcara({Key? key}) : super(key: key);

  @override
  State<PickPointAcara> createState() => _PickPointAcaraState();
}

class _PickPointAcaraState extends State<PickPointAcara> {
  String googleApikey = "AIzaSyAxDHz9wq_emJzteeFbpbGMkIp2yuZXMvs";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(-6.200000, 106.816666);
  String location = "Search Location";
  var lat;
  var long;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pilih Lokasi"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 14.0, //initial zoom level
            ),
            mapType: MapType.normal, //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              cameraPosition = cameraPositiona;
            },
            onCameraIdle: () async {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              lat = cameraPosition!.target.latitude;
              long = cameraPosition!.target.longitude;
              setState(() {
                location = placemarks.first.administrativeArea.toString() +
                    ", " +
                    placemarks.first.street.toString() +
                    ", " +
                    placemarks.first.subLocality.toString() +
                    ", " +
                    placemarks.first.locality.toString() +
                    ", " +
                    placemarks.first.postalCode.toString() +
                    ", " +
                    placemarks.first.country.toString();
              });
            },
          ),

          Center(
            //picker image on google map
            child: Image.asset(
              "assets/images/google-maps.png",
              width: 320,
              height: 32,
            ),
          ),

          //search autoconplete input
          Positioned(
              //search input bar
              top: 10,
              child: InkWell(
                  onTap: () async {
                    Prediction? place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        radius: 1000,
                        region: "id",
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'id')],
                        //google_map_webservice package
                        onError: (err) {
                          print(err);
                        });

                    if (place != null) {
                      setState(() {
                        location = place.description.toString();
                      });
                      //form google_maps_webservice package
                      final plist = GoogleMapsPlaces(
                        apiKey: googleApikey,
                        apiHeaders: await GoogleApiHeaders().getHeaders(),
                        //from google_api_headers package
                      );
                      String placeid = place.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang);

                      //move map camera to selected place with animation
                      mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(target: newlatlang, zoom: 17)));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            leading: Image.asset(
                              "assets/images/google-maps.png",
                              width: 25,
                            ),
                            title: Text(
                              location,
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing: Icon(Icons.search),
                            dense: true,
                          )),
                    ),
                  ))),
          Positioned(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  print("Lokasi : " + location);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailAcara(
                                location: location,
                                lat: lat,
                                long: long,
                              )));
                },
                child: Text("Pilih Lokasi")),
            bottom: 10,
            //button center
            left: MediaQuery.of(context).size.width / 2 - 50,
          )
        ]));
  }
}
