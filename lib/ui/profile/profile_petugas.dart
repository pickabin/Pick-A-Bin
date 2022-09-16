import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:boilerplate/data/service/auth_service.dart';
import 'package:boilerplate/ui/update_profile/update_petugas_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePetugasPage extends StatefulWidget {
  const ProfilePetugasPage({Key? key}) : super(key: key);

  @override
  State<ProfilePetugasPage> createState() => _ProfilePetugasPageState();
}

class _ProfilePetugasPageState extends State<ProfilePetugasPage> {
  File? _image;
  String? fileName;
  String? url;
  //Read data once from Realtime Database
  final ref = FirebaseDatabase.instance.ref().child('petugas');
  AuthService authService = AuthService();

  // Upload dan get image from firebase storage
  Future _getImageCamera(key) async {
    DatabaseReference data = FirebaseDatabase.instance.ref("petugas/$key");

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
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    if (fileName != null) {
      Reference storageRef = storage.ref().child("imagePetugas/" + fileName!);
      await storageRef.putFile(_image!);

      storageRef.getDownloadURL().then((value) {
        setState(() {
          url = value;
          data.update({"imageUrl": url});
        });
      });
    }
  }

  //Upload dan get image gallery from storage
  Future _getImageGallery(key) async {
    DatabaseReference data = FirebaseDatabase.instance.ref("petugas/$key");

    var selectImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
    if (selectImage != null) {
      setState(() {
        _image = File(selectImage.path);
        fileName = basename(_image!.path);
      });
    }

    if (fileName != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef = storage.ref().child("imagePetugas/" + fileName!);
      await storageRef.putFile(_image!);

      storageRef.getDownloadURL().then((value) {
        setState(() {
          url = value;
          data.update({"imageUrl": url});
        });
      });
    }
  }

//Hapus Image from firebase storage
  Future _removeImage(key) async {
    DatabaseReference data = FirebaseDatabase.instance.ref("petugas/$key");
    setState(() {
      _image = null;
      url = null;
      data.update({"imageUrl": url});
    });
  }

  @override
  // DatabaseReference ref = FirebaseDatabase.instance.ref("petugas/1001");
  // Future<void> initState() async {
  //   super.initState();
  //   DatabaseEvent event = await ref.once();
  // }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Profile',
              style: TextStyle(color: Color(0xff00783E)),
            ),
            leadingWidth: 100,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff00783E),
            ),
            label: const Text(
              'Back',
              style: TextStyle(color: Color(0xff00783E)),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0, primary: Colors.transparent),
          ),
          ),
        body: FutureBuilder(
            future: _getPrefs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return FirebaseAnimatedList(
                    query:
                        ref.orderByChild('email').equalTo("${snapshot.data}"),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Center(),
                                  const SizedBox(
                                    height: 85.0,
                                  ),
                                  Container(
                                    height: 500.0,
                                    width: 320,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.black12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //Nama Lengkap
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 100.0, left: 30.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Nama Lengkap',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                snapshot
                                                    .child('nama')
                                                    .value
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //Alamat
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 15.0, left: 30.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Alamat',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                snapshot
                                                    .child('alamat')
                                                    .value
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //Alamat
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 15.0, left: 30.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'No Telepon',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                snapshot
                                                    .child('telp')
                                                    .value
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //Email
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 15.0, left: 30.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Email',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                snapshot
                                                    .child('email')
                                                    .value
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //Button Logout
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 30.0,
                                              left: 15.0,
                                              right: 30.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Container(
                                              //   width: double.infinity,
                                              //   child: ElevatedButton(
                                              //     child: const Center(
                                              //       child: Text(
                                              //         'Logout',
                                              //         style: TextStyle(
                                              //           fontSize: 20,
                                              //           color: Colors.white,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     style:
                                              //         ElevatedButton.styleFrom(
                                              //       primary: Colors.green,
                                              //       shape:
                                              //           RoundedRectangleBorder(
                                              //         borderRadius:
                                              //             BorderRadius.circular(
                                              //                 20.0),
                                              //       ),
                                              //     ),
                                              //     onPressed: () async {
                                              //       SharedPreferences prefs =
                                              //           await SharedPreferences
                                              //               .getInstance();
                                              //       // prefs.remove('uid');
                                              //       prefs.clear();
                                              //       authService.logout();
                                              //       Navigator.pushReplacement(
                                              //           context,
                                              //           MaterialPageRoute(
                                              //               builder: (context) =>
                                              //                   RoleSelection()));
                                              //     },
                                              //   ),
                                              // ),
                                              Container(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  child: const Center(
                                                    child: Text(
                                                      'Update Profile',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    // // prefs.remove('uid');
                                                    // prefs.clear();
                                                    // authService.logout();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UpdatePetugasPage()));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              //circle image
                              Positioned(
                                top: 20,
                                left:
                                    MediaQuery.of(context).size.width / 2 - 70,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            height: 140,
                                            width: 140,
                                            child: snapshot
                                                        .child('imageUrl')
                                                        .value !=
                                                    null
                                                ? CircleAvatar(
                                                    radius: 60,
                                                    backgroundImage:
                                                        NetworkImage(snapshot
                                                            .child('imageUrl')
                                                            .value
                                                            .toString()))
                                                : CircleAvatar(
                                                    radius: 60,
                                                    backgroundColor:
                                                        Colors.green,
                                                    child: CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/images/user_icon.png'),
                                                      radius: 68,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 5,
                                      bottom: 10,
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 70,
                                          child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        "Pilih Foto",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                              child: ListBody(
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              var key =
                                                                  snapshot.key;
                                                              _getImageCamera(
                                                                  key);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            splashColor: Colors
                                                                .greenAccent,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .camera,
                                                                    color: Colors
                                                                        .green,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Camera',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .blue),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              var key =
                                                                  snapshot.key;
                                                              _getImageGallery(
                                                                  key);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            splashColor: Colors
                                                                .greenAccent,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Icon(
                                                                    Icons.image,
                                                                    color: Colors
                                                                        .green,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Gallery',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .blue),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              var key =
                                                                  snapshot.key;
                                                              _removeImage(key);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            splashColor: Colors
                                                                .purpleAccent,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Remove',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .red),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.camera_alt_rounded,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 60.0,
                          ),
                        ],
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Future<String?> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }
}
