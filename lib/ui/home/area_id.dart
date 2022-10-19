import 'package:boilerplate/controllers/jadwal_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AreaId extends StatefulWidget {
  const AreaId({Key? key}) : super(key: key);

  @override
  _AreaIdState createState() => _AreaIdState();
}

class _AreaIdState extends State<AreaId> {
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
                                labelText: 'ex: D4Mul',
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
                                    color: Colors.red,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.qr_code_scanner),
                                  onPressed: () {},
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
                                labelText: 'ex: Toilet, Ruang Kelas',
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
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Update Jadwal Failed",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        });
                                      }else{
                                        JadwalController.updateJadwalKoor(
                                                kodeGedungController.text,
                                                namaTempatController.text)
                                            .then((value) {
                                          if (value.statusCode == 200) {
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Update Jadwal Successfully",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Update Jadwal Failed",
                                                toastLength: Toast.LENGTH_SHORT,
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
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
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