import 'package:boilerplate/controllers/aktivitas_petugas_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
              return snapshot.data.length != 0 ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return snapshot.data[index].status == null ? Column(
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
                                          // print("ini bukti id aktivitas" + snapshot.data[index].id.toString());
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Tidak")),
                                    TextButton(
                                        onPressed: () {
                                          var key = snapshot.data[index].id;
                                          AktivitasPetugasController
                                              .deleteAktivitasPetugas(key);
                                              setState(() {
                                                Navigator.pop(context);
                                              });
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
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
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
                                Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                          child: Icon(Icons.calendar_today,
                                              color: Colors.green)),
                                     DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                          snapshot.data[index].date
                                              .toString())) ==
                                      DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                  ? TextSpan(
                                          text: DateFormat('HH:mm').format(
                                      DateTime.parse(snapshot.data[index].time
                                              .toString())
                                      ).toString()) 
                                      : DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                          snapshot.data[index].date
                                              .toString())) ==
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.now()
                                                  .subtract(Duration(days: 1))) ?
                                        TextSpan(
                                          text: "Yesterday",
                                          style: TextStyle(color: Colors.grey)) :
                                        TextSpan(
                                          text:  DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(snapshot.data[index].date.toString()))
                                        )   
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff4399A7),
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: "Sedang ditinjau"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Column(children: <Widget>[
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
                  ) : snapshot.data[index].status == 1 ? Column(
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
                                          // print("ini bukti id aktivitas" + snapshot.data[index].id.toString());
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Tidak")),
                                    TextButton(
                                        onPressed: () {
                                          var key = snapshot.data[index].id;
                                          AktivitasPetugasController
                                              .deleteAktivitasPetugas(key);
                                              setState(() {
                                                Navigator.pop(context);
                                              });
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
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
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
                                Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                          child: Icon(Icons.calendar_today,
                                              color: Colors.green)),
                                     DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                          snapshot.data[index].date
                                              .toString())) ==
                                      DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                  ? TextSpan(
                                          text: DateFormat('HH:mm').format(
                                      DateTime.parse(snapshot.data[index].time
                                              .toString())
                                      ).toString()) 
                                      : DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                          snapshot.data[index].date
                                              .toString())) ==
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.now()
                                                  .subtract(Duration(days: 1))) ?
                                        TextSpan(
                                          text: "Yesterday",
                                          style: TextStyle(color: Colors.grey)) :
                                        TextSpan(
                                          text:  DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(snapshot.data[index].date.toString()))
                                        )   
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff4399A7),
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: "Selesai"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Column(children: <Widget>[
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
                  ) : Container(
                    child: Text("oke"),
                  );
                },
              ) : Center(child: Text("Tidak ada aktivitas"));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  // Future<String?> _getPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? nama = prefs.getString('nama');
  //   return nama;
  // }
}
