import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/service/auth_service.dart';

class AktifitasWarga extends StatefulWidget {
  AktifitasWarga({Key? key}) : super(key: key);

  @override
  State<AktifitasWarga> createState() => _AktifitasWargaState();
}

class _AktifitasWargaState extends State<AktifitasWarga> {
  final ref = FirebaseDatabase.instance.ref().child('aktivitas');


  // final data = FirebaseDatabase.instance.ref().child('aktivitas').child('penanggungJawab');
  AuthService authService = AuthService();

  //check empty list realtime database
  @override
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Aktivitas',
          style: TextStyle(color: Color(0xff00783E)),
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 100,
      ),
      body: FutureBuilder(
          future: _getPrefs(),
          builder: (context, snapshot) {
           
            if (snapshot.hasData) {
              print("nama : ${snapshot.data}");
              
              //cek data kosong
                return FirebaseAnimatedList(
                  query: ref
                      .orderByChild('penanggungJawab')
                      .equalTo("${snapshot.data}"),
                  

                  //get email from shared preference
                  
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                        //jika data kosong
                      //if snapshot empty
                      
                      return Column(
                      children: <Widget>[
                        // snapshot.child('penanggungJawab').value.toString() == 'null' ?
                        Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: Text("Hapus",
                                style: TextStyle(color: Colors.white)),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                          ),
                          confirmDismiss: (direction) {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Konfirmasi"),
                                    content: Text(
                                        "Apakah Anda yakin akan menghapus aktivitas ini? "),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Tidak")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            var key = snapshot.key;
                                            DatabaseReference del =
                                                FirebaseDatabase.instance
                                                    .ref("aktivitas/$key");
                                            del.remove();
                                          },
                                          child: Text("Yakin")),
                                    ],
                                  );
                                });
                          },
                          child:Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text.rich(
                                TextSpan(
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: 'Sampah anda sudah diambil',
                                    ),
                                  ],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text.rich(
                                TextSpan(
                                  children: <InlineSpan>[
                                    WidgetSpan(
                                        child: Icon(Icons.location_on_outlined,
                                            color: Colors.green)),
                                    TextSpan(
                                        text: snapshot
                                            .child('alamat')
                                            .value
                                            .toString()+ "\n"),
                                  WidgetSpan(
                                        child: Icon(Icons.cleaning_services,
                                            color: Colors.green)),
                                    TextSpan(
                                      text: "diambil oleh " +
                                          snapshot.child('petugas').value.toString(),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: snapshot
                                          .child('tanggal')
                                          .value
                                          .toString() ==
                                      DateFormat('dd/MM/yyyy')
                                          .format(DateTime.now())
                                  ? Text(
                                      snapshot.child('waktu').value.toString(),
                                      style: TextStyle(color: Colors.grey))
                                  : snapshot
                                              .child('tanggal')
                                              .value
                                              .toString() ==
                                          DateFormat('dd/MM/yyyy').format(
                                              DateTime.now()
                                                  .subtract(Duration(days: 1)))
                                      ? Text("Yesterday",
                                          style: TextStyle(color: Colors.grey))
                                      : Text(
                                          snapshot
                                              .child('tanggal')
                                              .value
                                              .toString(),
                                          style: TextStyle(color: Colors.grey)),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/activity_icon.png"),
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        )
                        // : Center(
                        //   child: Text("Tidak ada aktivitas"),
                        // )
                        ,
                        Divider(color: Colors.black)
                      ],
                    );
                  });
               
               
            } else {
              return Center(
                child: Text("Belum ada aktivitas"),
              );
            }
          }),
    );
  }

  Future<String?> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nama = prefs.getString('nama');
    return nama;
  }
}
