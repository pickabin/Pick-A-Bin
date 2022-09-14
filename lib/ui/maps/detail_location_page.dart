import 'package:boilerplate/data/repository/maps_utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailLocationPage extends StatefulWidget {
  final String nama;
  final double lat;
  final double long;
  final String alamat;
  const DetailLocationPage({Key? key, required this.lat, required this.long, required this.nama, required this.alamat})
      : super(key: key);

  @override
  State<DetailLocationPage> createState() => _DetailLocationPageState();
}

class _DetailLocationPageState extends State<DetailLocationPage> {
  String address = "Alamat Kosong";

  Future<Placemark> getAddressFromLatLng() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.lat, widget.long, localeIdentifier: 'id');
    Placemark place = placemarks[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.subAdministrativeArea}';
    });
    return place;
  }

  Future<void> requestPermission() async { 
    await Permission.location.request(); 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddressFromLatLng();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Container(
            height: 5,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 122, 122, 122),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "Detail Lokasi",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
                child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Pemilik",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      widget.nama,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Alamat",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      address,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: Text(
                      "Status Pengambilan",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: true,
                    onChanged: (value) {
                      setState(() {
                        value = true;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Center(
                          child: Text(
                            'Direction',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          MapsUtils.openMap(widget.lat, widget.long);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}