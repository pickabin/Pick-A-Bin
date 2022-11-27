import 'dart:async';
import 'dart:io';
import 'package:boilerplate/controllers/jadwal_controller.dart';
import 'package:boilerplate/ui/activity/petugas_activity_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class JadwalPetugasCameraPage extends StatefulWidget {
  JadwalPetugasCameraPage({Key? key}) : super(key: key);

  @override
  State<JadwalPetugasCameraPage> createState() =>
      _JadwalPetugasCameraPageState();
}

class _JadwalPetugasCameraPageState extends State<JadwalPetugasCameraPage> {
  File? _image;
  String? fileName;
  String? url;

  Future _getImageCamera(id) async {
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
      });

      FirebaseStorage storage = FirebaseStorage.instance;
      if (fileName != null) {
        Reference storageRef =
            storage.ref().child("imageAktivitas/" + fileName!);
        await storageRef.putFile(_image!);

        storageRef.getDownloadURL().then((value) {
          setState(() {
            url = value;
            JadwalController.updateJadwal(url!, id).then((value) {
              print("ini jadwal id yang dikirim $id");
              if (value.statusCode == 200) {
                Fluttertoast.showToast(
                    msg: "Update Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.push(
                    this.context,
                    MaterialPageRoute(
                        builder: (context) => PetugasActivityPage()));
              } else {
                Fluttertoast.showToast(
                    msg: "Update Failed",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            });
          });
        });
        print("GET URL");
      }

      //redirect image preview
      // Navigator.pushReplacement(
      //   this.context,
      //   MaterialPageRoute(
      //     builder: (context) => ImagePreview(image: _image, fileName: fileName),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Jadwal',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
        ),
        body: FutureBuilder(
          future: JadwalController().getJadwal(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text("Tidak ada jadwal"),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return snapshot.data[index].status.toString() == "0"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: Text(
                                "Piket" +
                                    " " +
                                    snapshot.data[index].keterangan.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                snapshot.data[index].cleanArea.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // date time now
                              subtitle: Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(
                                      DateTime.now(),
                                    )
                                    .toString(),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Color(0xff4399A7),
                                child: Icon(Icons.wysiwyg, color: Colors.white),
                              ),
                              trailing: new Wrap(
                                children: <Widget>[
                                  Container(
                                    child: new IconButton(
                                      icon: new Icon(Icons.camera_alt_rounded,
                                          color: Color(0xff1DDB7F)),
                                      onPressed: () {
                                        _getImageCamera(
                                            snapshot.data[index].id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : //widget kosong;
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: Text(
                                "Piket" +
                                    " " +
                                    snapshot.data[index].keterangan.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                snapshot.data[index].cleanArea.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text("Piket Telah Dilaksanakan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    )
                                  ),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Color(0xff4399A7),
                                child: Icon(Icons.wysiwyg, color: Colors.white),
                              ),
                              // trailing icon check
                              trailing: new Wrap(
                                children: <Widget>[
                                  Container(
                                    child: new IconButton(
                                      icon: new Icon(Icons.done_all,
                                          color: Color(0xff1DDB7F)),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                },
              );
            } else {
              return ListTileShimmer();
            }
          },
        ));
  }

  // Future<String?> _getRole() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? role = prefs.getString('role');
  //   return role;
  // }
}
