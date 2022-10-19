import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class ListDonePage extends StatelessWidget {
  ListDonePage({Key? key}) : super(key: key);
  final fb = FirebaseDatabase.instance;
  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('jadwal').orderByChild('status').equalTo(true);

    return Scaffold(
      body: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Timer(Duration(minutes: 1), () {});
            return InkWell(
              child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Budi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Ruang C102"),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/user_icon.png"),
                      ),
                      trailing: new Wrap(
                        children: <Widget>[
                          new Container(
                            child: new IconButton(
                              icon: new Icon(Icons.highlight_off,
                                  color: Colors.orange),
                              onPressed: () {
                                var key = snapshot.key;
                                DatabaseReference up = FirebaseDatabase.instance
                                    .ref("jadwal/$key");
                                up.update({
                                  "status": false,
                                });
                              },
                            ),
                          ),
                          // new Container(
                          //   child: new IconButton(
                          //     icon: new Icon(Icons.done_outline_outlined,
                          //         color: Colors.green),
                          //     onPressed: () async {
                          //       final SharedPreferences prefs =
                          //           await SharedPreferences.getInstance();
                          //       databaseRef
                          //           .child("aktivitas_petugas")
                          //           .push()
                          //           .set({
                          //         'instansi': snapshot
                          //             .child('instansi')
                          //             .value
                          //             .toString(),
                          //         'penanggungJawab': snapshot
                          //             .child('penanggungJawab')
                          //             .value
                          //             .toString(),
                          //         'alamat':
                          //             snapshot.child('alamat').value.toString(),
                          //         'telp':
                          //             snapshot.child('telp').value.toString(),
                          //         'tanggal': DateFormat('dd/MM/yyyy')
                          //             .format(DateTime.now())
                          //             .toString(),
                          //         'waktu': DateFormat('hh:mm')
                          //             .format(DateTime.now())
                          //             .toString(),
                          //         'petugas': prefs.getString('nama'),
                          //       });
                          //       databaseRef
                          //           .child("aktivitas_warga")
                          //           .push()
                          //           .set({
                          //         'instansi': snapshot
                          //             .child('instansi')
                          //             .value
                          //             .toString(),
                          //         'penanggungJawab': snapshot
                          //             .child('penanggungJawab')
                          //             .value
                          //             .toString(),
                          //         'alamat':
                          //             snapshot.child('alamat').value.toString(),
                          //         'telp':
                          //             snapshot.child('telp').value.toString(),
                          //         'tanggal': DateFormat('dd/MM/yyyy')
                          //             .format(DateTime.now())
                          //             .toString(),
                          //         'waktu': DateFormat('hh:mm')
                          //             .format(DateTime.now())
                          //             .toString(),
                          //         'petugas': prefs.getString('nama'),
                          //       });
                          //       var key = snapshot.key;
                          //       var jarakPengambilan = snapshot
                          //           .child('jarakPengambilan')
                          //           .value
                          //           .toString();
                          //       DatabaseReference up = FirebaseDatabase.instance
                          //           .ref("jadwal/$key");
                          //       up.update({
                          //         "date": DateFormat('dd/MM/yyyy').format(
                          //             DateTime.now().add(Duration(
                          //                 days: int.parse(jarakPengambilan)))),
                          //         "status": false,
                          //       });
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
