import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LaporanPage extends StatefulWidget {
  @override
  _LaporanPageState createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  final TextEditingController namaController = new TextEditingController();
  final TextEditingController isiController = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey();
  CollectionReference laporan =
      FirebaseFirestore.instance.collection('laporan');

  @override
  Widget build(BuildContext context) {
    String nama;
    String isi;
    return Scaffold(
        appBar: AppBar(
          title: Text("Saran dan Masukan"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Color(0xffe6e6e6),
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                              errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Saran atau masukan harus Diisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Color(0xffe6e6e6),
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 35, horizontal: 20),
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
                              errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.red,
                              ),
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
                            if (_formKey.currentState!.validate()) {}
                            nama = namaController.text;
                            isi = isiController.text;
                  
                          if(nama.isNotEmpty && isi.isNotEmpty){
                            setState(() {
                              laporan
                                  .add({
                                    'nama': nama,
                                    'isi_laporan': isi,
                                  })
                                  .then((value){
                                    showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Berhasil'),
                                      content: const Text('Terima kasih sarannya'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ));
                                  })
                                  .catchError(
                                      (error) => print("Failed to add user: $error"));
                            });
                          }                           
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
                    ])),
          ),
        ));
  }
}