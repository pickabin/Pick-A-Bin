import 'package:boilerplate/data/repository/maps_utils.dart';
import 'package:boilerplate/ui/maps/detail_location_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsDistributionPage extends StatefulWidget {
  const MapsDistributionPage({Key? key}) : super(key: key);

  @override
  State<MapsDistributionPage> createState() => _MapsDistributionPageState();
}

class _MapsDistributionPageState extends State<MapsDistributionPage> {
  GoogleMapController? myController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId)async{
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify['lat'], specify['long']),
      infoWindow: InfoWindow(
        title: specify['penanggungJawab'], 
        snippet: specify['alamat'],
        onTap: (){
          MapsUtils.openMap(specify['lat'], specify['long']);
        }
      ),
      onTap: (){
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
                  child: DetailLocationPage(nama:specify['penanggungJawab'],lat: specify['lat'], long: specify['long'],alamat:specify['alamat'],),
                );
              },
            );
      } 
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData()async{
    FirebaseFirestore.instance.collection('lokasi').get().then((location) {
      if(location.docs.isNotEmpty){
        for(int i=0; i<location.docs.length; i++){
          initMarker(location.docs[i].data(), location.docs[i].id);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // Set<Marker> getMarker(){
    //   return <Marker>[
    //     Marker(
    //       markerId: MarkerId('myMarker'),
    //       position: LatLng(-6.17511, 106.82598),
    //       icon: BitmapDescriptor.defaultMarker,
    //       infoWindow: InfoWindow(
    //         title: 'My Marker',
    //         snippet: 'This is my marker',
    //       ),
    //     )
    //   ].toSet();
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Google Maps',
          style: TextStyle(color: Colors.green),
        ),
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-7.2574719, 112.75208829999997),
          zoom: 9,
        ),
        onMapCreated: (GoogleMapController controller) {
          myController = controller;
        },
      ),
    );
  }
}