import 'package:boilerplate/controllers/lapor_acara_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifAcara extends StatefulWidget {
  NotifAcara({Key? key}) : super(key: key);

  @override
  State<NotifAcara> createState() => _NotifAcaraState();
}

class _NotifAcaraState extends State<NotifAcara> {
  // final ref = FirebaseDatabase.instance
  //     .ref()
  //     .child('aktivitas_petugas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   title: const Text(
        //     'Acara',
        //     style: TextStyle(color: Color(0xff00783E)),
        //   ),
        //   automaticallyImplyLeading: false,
        //   leadingWidth: 100,
        // ),
        body: FutureBuilder(
            future: LaporAcaraController().getLaporAcara(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return snapshot.data.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: <Widget>[
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
                                                    // Navigator.of(context).pop();
                                                    // var key = snapshot.key;
                                                    // DatabaseReference del = FirebaseDatabase
                                                    //     .instance
                                                    //     .ref("aktivitas_petugas/$key");
                                                    // del.remove();
                                                  },
                                                  child: Text("Yakin")),
                                            ],
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      title: Text.rich(
                                        TextSpan(
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: snapshot.data[index].title,
                                            ),
                                          ],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      subtitle: Text.rich(
                                        TextSpan(
                                          children: <InlineSpan>[
                                            WidgetSpan(
                                                child: Icon(Icons.list_alt,
                                                    color: Colors.green)),
                                            TextSpan(
                                                text: snapshot.data[index]
                                                        .description +
                                                    '\n'),
                                            WidgetSpan(
                                                child: Icon(Icons.date_range,
                                                    color: Colors.green)),
                                            TextSpan(
                                                text: DateFormat.yMMMMEEEEd()
                                                    .format(snapshot
                                                        .data[index].time)
                                                    .toString()),
                                          ],
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                        child: Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.lightGreen,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.black),
                              ],
                            ),
                          );
                        })
                    : Center(child: Text('Tidak ada acara'));
              } else {
                return Column(children: [
                  ListTileShimmer(),
                  ListTileShimmer(),
                  ListTileShimmer(),
                  ListTileShimmer(),
                  ListTileShimmer(),
                ]);
              }
            }));
  }

  // Future<String?> _getPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? nama = prefs.getString('nama');
  //   return nama;
  // }
}
