import 'dart:async';
import 'dart:io';
import 'package:boilerplate/ui/image/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class JadwalCameraPage extends StatefulWidget {
  JadwalCameraPage({Key? key}) : super(key: key);

  @override
  State<JadwalCameraPage> createState() => _JadwalCameraPageState();
}

class _JadwalCameraPageState extends State<JadwalCameraPage> {
  File? _image;
  String? fileName;
  String? url;

  Future _getImageCamera() async {
    XFile? selectImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    if (selectImage != null) {
      setState(() {
        _image = File(selectImage.path);
        fileName = basename(_image!.path);

        //redirect image preview
        Navigator.pushReplacement(
          this.context,
          MaterialPageRoute(
            builder: (context) =>
                ImagePreview(image: _image, fileName: fileName),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getRole(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: snapshot.data == "petugas"
                  ? AppBar(
                      backgroundColor: Colors.green,
                      title: Text("Jadwal"),
                    )
                  : null,
              body: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Ruang C102",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("11-12-2022"),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.home, color: Colors.white),
                    ),
                    trailing: new Wrap(
                      children: <Widget>[
                          Container(
                          child: new IconButton(
                            icon: new Icon(Icons.camera_alt_rounded,
                                color: Colors.orange),
                            onPressed: () {
                              _getImageCamera().then((value) {
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListTileShimmer();
          }
        });
  }

  Future<String?> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? role = prefs.getString('role');
    return role;
  }
}
