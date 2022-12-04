import 'package:boilerplate/controllers/jadwal_controller.dart';
import 'package:boilerplate/ui/qrview/qr_scan_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AreaIdKoor extends StatefulWidget {
  String? code;
  String? cleanArea;
  AreaIdKoor({Key? key, required this.code}) : super(key: key);

  @override
  _AreaIdKoorState createState() => _AreaIdKoorState();
}

class _AreaIdKoorState extends State<AreaIdKoor> {
  final GlobalKey<FormState> _formKey = new GlobalKey();
  final TextEditingController kodeGedungController =
      new TextEditingController();
  final TextEditingController namaTempatController =
      new TextEditingController();
  String? role;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
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
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, top: 20, right: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Kode gedung",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "kode gedung digunakan untuk mendapatkan jadwal",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black45),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, top: 30, right: 30),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Masukkan kode gedung",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: kodeGedungController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Kode Gedung Harus Diisi';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'ex: D4PENS',
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.green,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(8),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.green,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 221, 206, 205),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.qr_code_scanner),
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) {
                                        return QRScanPage();
                                      },
                                    ));
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Masukkan Nama Tempat",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: namaTempatController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nama Tempat Harus Diisi';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'ex: Lt2',
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.green,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(8),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
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
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  role = prefs.getString('role');
                                  print("Ini role $role");
                                  if (_formKey.currentState!.validate()) {
                                    if (kodeGedungController.text.isNotEmpty ||
                                        namaTempatController.text.isNotEmpty) {
                                      //get shared preference role

                                      if (widget.code != null) {
                                        if (role == 'petugas') {
                                          JadwalController
                                              .updateCodeCleanPetugas(
                                            kodeGedungController.text,
                                            namaTempatController.text,
                                          ).then((value) {
                                            if (value.statusCode == 200) {
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Update Jadwal Successfully",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Update Jadwal code petugas Failed",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          });
                                        } else {
                                          JadwalController.updateCodeCleanKoor(
                                            kodeGedungController.text,
                                            namaTempatController.text,
                                          ).then((value) {
                                            if (value.statusCode == 200) {
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Update Jadwal Successfully",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Update Jadwal code koor Failed",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          });
                                        }
                                      } else {
                                        if (role == 'petugas') {
                                          JadwalController.updateJadwalPetugas(
                                                  kodeGedungController.text,
                                                  namaTempatController.text)
                                              .then((value) {
                                            if (value.statusCode == 200) {
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Update Jadwal Successfully",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Update Jadwal Failed",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          });
                                        } else {
                                          JadwalController.updateJadwalKoor(
                                                  kodeGedungController.text,
                                                  namaTempatController.text)
                                              .then((value) {
                                            if (value.statusCode == 200) {
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Update Jadwal Successfully",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Update Jadwal Failed",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          });
                                        }
                                      }
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: widget.code != null
                                    ? Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        "Submit",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
