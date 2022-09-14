import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LaporanPage extends StatefulWidget {
  @override
  _LaporanPageState createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  final TextEditingController namaController = new TextEditingController();
  final TextEditingController isiController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Saran dan Masukan"),
          backgroundColor: Colors.green,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 13),
                      child: Text(
                        "Saran dan masukan dari anda akan sangat membantu kami dalam mengembangkan aplikasi kedepannya",
                        style: TextStyle(
                          fontSize: 17.5,
                          height: 1.3,
                          fontFamily: 'RobotoSlab',
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: namaController,
                        decoration: InputDecoration(
                          fillColor: Color(0xffe6e6e6),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          hintText: 'Your name',
                          hintStyle: TextStyle(
                              color: Colors.blueGrey, fontFamily: 'RobotoSlab'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0001,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: isiController,
                        decoration: InputDecoration(
                          fillColor: Color(0xffe6e6e6),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 35, horizontal: 20),
                          hintText: 'Your message',
                          hintStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'RobotoSlab',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(17),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(17),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(17),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Card(
                      color: Colors.green[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () async {
                          print("Ini nama : " + namaController.text.trim());
                          print("Ini isi : " + isiController.text.trim());
                          CollectionReference laporan =
                              FirebaseFirestore.instance.collection('laporan');

                          setState(() {
                            laporan
                                .add({
                                  'nama': namaController.text.trim(),
                                  'isi_laporan': isiController.text.trim(),
                                })
                                .then((value) => print("Laporan Masuk"))
                                .catchError(
                                    (error) => print("Failed to add: $error"));
                          });
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Berhasil'),
                                    content:
                                        const Text('Terima kasih sarannya'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        },
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                  child: Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Center(
                                  child: Text(
                                "Send",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'RobotoSlab'),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                  ]),
            )));
  }
}
