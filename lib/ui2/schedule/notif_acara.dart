import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifAcara extends StatefulWidget {

  NotifAcara({Key? key}) : super(key: key);

  @override
  State<NotifAcara> createState() => _NotifAcaraState();
}

class _NotifAcaraState extends State<NotifAcara> {
  final ref = FirebaseDatabase.instance
      .ref()
      .child('aktivitas_petugas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Acara',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
        ),
        body: FutureBuilder(
            future: _getPrefs(),
            builder: (context,snapshot){
              print("name : ${snapshot.data}");
              if(snapshot.hasData){
                return Container(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: FirebaseAnimatedList(
                      query: ref.orderByChild('petugas').equalTo("${snapshot.data}"),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return Column(
                          children: <Widget>[
                            Dismissible(
                              key: Key(index.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                child:
                                Text("Hapus", style: TextStyle(color: Colors.white)),
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
                                                DatabaseReference del = FirebaseDatabase
                                                    .instance
                                                    .ref("aktivitas_petugas/$key");
                                                del.remove();
                                              },
                                              child: Text("Yakin")),
                                        ],
                                      );
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  title: Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: 'Nama Acara',
                                        ),
                                      ],
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        WidgetSpan(
                                            child: Icon(Icons.home_filled,
                                                color: Colors.green)),
                                        TextSpan(
                                            text: 'Tempat SPE Lantai 3 \n'
                                        ),
                                        WidgetSpan(
                                            child: Icon(Icons.timer_rounded,
                                                color: Colors.green)),
                                        TextSpan(
                                            text: '12.00'
                                        ),
                                        ],
                                    ),
                                  ),
                                  trailing: Column(children: <Widget>[
                                    Wrap(
                                      children: <Widget>[
                                        Icon(Icons.arrow_back),
                                      ],
                                    ),
                                  ]),
                                  leading: CircleAvatar(
                                    child: Icon(Icons.calendar_month_outlined),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: Colors.black),
                          ],
                        );
                      }),
                );
              }else{
                return Center(child: Text("Tidak ada aktivitas"));
              }
            }
        ));
  }

  Future<String?> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nama = prefs.getString('nama');
    return nama;
  }
}
