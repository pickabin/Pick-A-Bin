import 'dart:io';
import 'package:boilerplate/controllers/user_controller.dart';
import 'package:boilerplate/ui/navbar/navbar_page.dart';
import 'package:boilerplate/ui/profile/profile_koordinator_main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/service/auth_service.dart';
import 'package:path/path.dart';

class UpdateKoordinatorPage extends StatefulWidget {
  String? name;
  String? phone;
  String? email;
  String? imageUrl;
  String? address;
  int? id;
  UpdateKoordinatorPage(
      {Key? key,
      required this.name,
      required this.phone,
      required this.email,
      required this.imageUrl,
      required this.address,
      required this.id})
      : super(key: key);

  @override
  State<UpdateKoordinatorPage> createState() => _UpdateKoordinatorPageState();
}

class _UpdateKoordinatorPageState extends State<UpdateKoordinatorPage> {
  AuthService authService = AuthService();

  File? _image;
  String? fileName;
  String? url;
  //Read data once from Realtime Database
  final ref = FirebaseDatabase.instance.ref().child('Koordinator');

// Upload dan get image from firebase storage
  Future _getImageCamera(key) async {
    // DatabaseReference data = FirebaseDatabase.instance.ref("Koordinator/$key");

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
  }

  //Upload dan get image gallery from storage
  Future _getImageGallery(key) async {
    // DatabaseReference data = FirebaseDatabase.instance.ref("Koordinator/$key");

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
    
  }

//Hapus Image from firebase storage
  Future _removeImage(id) async {
    // DatabaseReference data = FirebaseDatabase.instance.ref("Koordinator/$key");
    setState(() {
      _image = null;
      url = '';
      //delete image
      UserController.updateUserImage(id, url!);
    });
  }

  final GlobalKey<FormState> _formKey = new GlobalKey();
  final _auth = AuthService();
  var namaLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Update Profile"),
      ),
      body: FutureBuilder(
        future: _getPrefs(),
        builder: (context, snapshot) {
          final TextEditingController _penanggungJawabController =
              new TextEditingController(text: widget.name);
          final TextEditingController _alamatController =
              new TextEditingController(text: widget.address);
          final TextEditingController _telpController =
              new TextEditingController(text: widget.phone);
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: Column(children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 140,
                width: 140,
                child: CircleAvatar(
                  child: _image != null
                      ? Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ).image,
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              right:
                                  MediaQuery.of(context).size.width * 0.00999,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavbarPage()));
                                },
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Pilih Foto',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            content: SingleChildScrollView(
                                                child: ListBody(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    var id = widget.id;
                                                    _getImageCamera(id);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileKoordinatorMain()));
                                                  },
                                                  splashColor:
                                                      Colors.greenAccent,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.camera,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.blue),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    var id = widget.id;
                                                    _getImageGallery(id);
                                                    Navigator.pop(context);
                                                  },
                                                  splashColor:
                                                      Colors.greenAccent,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.image,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.blue),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    var id = widget.id;

                                                    //refresh halaman
                                                    _removeImage(id);
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileKoordinatorMain()),
                                                        (route) =>
                                                            false).then(
                                                        (value) =>
                                                            setState(() {}));
                                                  },
                                                  splashColor:
                                                      Colors.purpleAccent,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Remove',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.red),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : widget.imageUrl != 'null'
                          ? Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.imageUrl.toString()),
                                  radius: 70,
                                ),
                                Positioned(
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.01,
                                  right: MediaQuery.of(context).size.width *
                                      0.00999,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NavbarPage()));
                                    },
                                    child: GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.camera_alt_rounded,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Pilih Foto',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                content: SingleChildScrollView(
                                                    child: ListBody(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        var id = widget.id;
                                                        _getImageCamera(id);
                                                        Navigator.pop(context);
                                                      },
                                                      splashColor:
                                                          Colors.greenAccent,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons.camera,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Camera',
                                                            style: TextStyle(
                                                                fontSize: 18,
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
                                                        var id = widget.id;
                                                        setState(() {
                                                          _getImageGallery(id);
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      splashColor:
                                                          Colors.greenAccent,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons.image,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                                fontSize: 18,
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
                                                        var id = widget.id;

                                                        //refresh halaman
                                                        _removeImage(id);
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NavbarPage()),
                                                            (route) =>
                                                                false).then(
                                                            (value) => setState(
                                                                () {}));
                                                      },
                                                      splashColor:
                                                          Colors.purpleAccent,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Colors.red),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/user_icon.png'),
                                  radius: 70,
                                ),
                                Positioned(
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.01,
                                  right: MediaQuery.of(context).size.width *
                                      0.00999,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NavbarPage()));
                                    },
                                    child: GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.camera_alt_rounded,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Pilih Foto',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                content: SingleChildScrollView(
                                                    child: ListBody(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        var id = widget.id;
                                                        _getImageCamera(id);
                                                        Navigator.pop(context);
                                                      },
                                                      splashColor:
                                                          Colors.greenAccent,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons.camera,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Camera',
                                                            style: TextStyle(
                                                                fontSize: 18,
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
                                                        var id = widget.id;
                                                        _getImageGallery(id);
                                                        Navigator.pop(context);
                                                      },
                                                      splashColor:
                                                          Colors.greenAccent,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons.image,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                                fontSize: 18,
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
                                                        var id = widget.id;

                                                        //refresh halaman
                                                        _removeImage(id);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      splashColor:
                                                          Colors.purpleAccent,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Colors.red),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                ),
              ),

              //create form with border
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //create email field
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 8.0),
                        //   child: Text(
                        //     "Nama Instansi",
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 5),
                        // TextFormField(
                        //   controller: _instansiController,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Nama Instansi Harus Diisi';
                        //     }
                        //     return null;
                        //   },
                        //   decoration: InputDecoration(
                        //     prefixIcon: Icon(
                        //       Icons.person,
                        //       color: Colors.green,
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //       borderSide: BorderSide(
                        //         width: 2,
                        //         color: Colors.green,
                        //       ),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //       borderSide: BorderSide(
                        //         width: 2,
                        //         color: Colors.green,
                        //       ),
                        //     ),
                        //     errorBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //       borderSide: BorderSide(
                        //         width: 2,
                        //         color: Colors.red,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Nama",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _penanggungJawabController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama Penanggung Jawab Harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Alamat",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _alamatController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Alamat Harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.home,
                              color: Colors.green,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "No.Telp",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _telpController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'No. Telp harus diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.green,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        // TextFormField(
                        //   controller: _tglAmbilSampahControler,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Pengambilan Sampah Harus Diisi';
                        //     }
                        //     return null;
                        //   },
                        //   decoration: InputDecoration(
                        //     prefixIcon: Icon(
                        //       Icons.date_range,
                        //       color: Colors.green,
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //       borderSide: BorderSide(
                        //         width: 2,
                        //         color: Colors.green,
                        //       ),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //       borderSide: BorderSide(
                        //         width: 2,
                        //         color: Colors.green,
                        //       ),
                        //     ),
                        //     errorBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //       borderSide: BorderSide(
                        //         width: 2,
                        //         color: Colors.red,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                // FirebaseAuth.instance
                                //     .authStateChanges()
                                //     .listen((User? user) {
                                //   if (user != null) {
                                //     namaLogin = user.displayName;
                                //   }
                                // });
                                var name =
                                    _penanggungJawabController.text.trim();
                                var alamat = _alamatController.text.trim();
                                var telp = _telpController.text.trim();

                                if (_formKey.currentState!.validate()) {}

                                if (_penanggungJawabController.text.isEmpty ||
                                    _alamatController.text.isEmpty ||
                                    _telpController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Data Tidak Boleh Kosong",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  // if (url != null) {
                                  //   KoorGedungController.updateImage(widget.id, url);
                                  // }

                                  if (fileName != null) {
                                    FirebaseStorage storage =
                                        FirebaseStorage.instance;
                                    Reference storageRef = storage
                                        .ref()
                                        .child("imageUser/" + fileName!);
                                    await storageRef.putFile(_image!);

                                    storageRef.getDownloadURL().then((value) {
                                      setState(() {
                                        url = value;
                                        // data.update({"imageUrl": url});
                                      });
                                    }).then((value){
                                      UserController.updateUserImage(widget.id, url);
                                    });
                                  }

                                  UserController.updateUser(
                                          widget.id, name, alamat, telp)
                                      .then((value) {
                                    if (value.statusCode == 200) {
                                      Fluttertoast.showToast(
                                          msg: "Data Berhasil Diubah",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Data Gagal Diubah",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  });

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavbarPage()));
                                }

                                // if (namaInstansi.isEmpty) {
                                //   print("Nama Instansi kosong");
                                // } else {
                                //   if (penanggungJawab.isEmpty) {
                                //     print("Penanggung Jawab kosong");
                                //   } else {
                                //     if (alamat.isEmpty) {
                                //       print("Alamat kosong");
                                //     } else {
                                //       if (email.isEmpty) {
                                //         print("Email kosong");
                                //       } else {
                                //         if (telp.isEmpty) {
                                //           print("No. Telp kosong");
                                //         } else {
                                //           if (tglAmbilSampah.isEmpty) {
                                //             print(
                                //                 "Tanggal Pengambilan Sampah kosong");
                                //           } else {
                                //             print(
                                //                 "penanggungJawab : $penanggungJawab");
                                //             print("email : $email");
                                //             var key = snapshot.key;
                                //             print(
                                //                 "penanggungJawab : $penanggungJawab");
                                //             print("email : $email");
                                //             //  authService
                                //             //       .updateEmail(email);
                                //             authService
                                //                 .updateDisplayName(
                                //                     penanggungJawab)
                                //                 .then((value) async {
                                //               DatabaseReference data =
                                //                   FirebaseDatabase
                                //                       .instance
                                //                       .ref(
                                //                           "Koordinator/$key");
                                //               data.update({
                                //                 "instansi":
                                //                     namaInstansi,
                                //                 "penanggungJawab":
                                //                     penanggungJawab,
                                //                 "alamat": alamat,
                                //                 "email": email,
                                //                 "telp": telp,
                                //                 "tglAmbilSampah":
                                //                     tglAmbilSampah,
                                //               });
                                //               //update data jadwal berdasarkan nama
                                //               DatabaseReference
                                //                   dataJadwal =
                                //                   FirebaseDatabase
                                //                       .instance
                                //                       .ref("jadwal");
                                //               dataJadwal.push().set({
                                //                 "instansi":
                                //                     namaInstansi,
                                //                 "date": DateFormat(
                                //                         'dd/MM/yyyy')
                                //                     .format(
                                //                         DateTime.now()),
                                //                 "penanggungJawab":
                                //                     penanggungJawab,
                                //                 "alamat": alamat,
                                //                 "email": email,
                                //                 "telp": telp,
                                //                 "jarakPengambilan":
                                //                     tglAmbilSampah,
                                //                 "konfirmasi": false,
                                //                 "status": false,
                                //               });
                                //             });

                                //           }
                                //         }
                                //       }
                                //     }
                                //   }
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                "Update Profile",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ]));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<String?> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }
}
