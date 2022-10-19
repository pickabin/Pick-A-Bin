import 'package:boilerplate/controllers/aktivitas_petugas_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetugasActivityPage extends StatefulWidget {
  PetugasActivityPage({Key? key}) : super(key: key);

  @override
  State<PetugasActivityPage> createState() => _PetugasActivityPageState();
}

class _PetugasActivityPageState extends State<PetugasActivityPage> {
  // final ref = FirebaseDatabase.instance
  //     .ref()
  //     .child('aktivitas_petugas');

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
          future: AktivitasPetugasController().getAktivitasPetugas(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
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
                                          Navigator.of(context).pop();
                                          var key = snapshot.data[index].id;
                                          AktivitasPetugasController
                                              .deleteAktivitasPetugas(key);
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
                                    text: 'Anda telah membersihkan',
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
                                          .data[index].jadwal.cleanArea),
                                ],
                              ),
                            ),
                            trailing: Column(children: <Widget>[
                              DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                          snapshot.data[index].date
                                              .toString())) ==
                                      DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                  ? Text(
                                    DateFormat('HH:mm').format(
                                      DateTime.parse(snapshot.data[index].time
                                              .toString())
                                      ).toString(),
                                      style: TextStyle(color: Colors.grey))
                                  : DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                          snapshot.data[index].date
                                              .toString())) ==
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.now()
                                                  .subtract(Duration(days: 1)))
                                      ? Text("Yesterday",
                                          style: TextStyle(color: Colors.grey))
                                      : Text(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(snapshot.data[index].date.toString())),
                                          style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 15),
                              Wrap(
                                children: <Widget>[
                                  Icon(Icons.arrow_back),
                                ],
                              ),
                            ]),
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/activity_icon.png"),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Divider(color: Colors.black),
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<String?> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nama = prefs.getString('nama');
    return nama;
  }
}
