import 'package:boilerplate/controllers/aktivitas_koor_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/service/auth_service.dart';

class KoorActivityPage extends StatefulWidget {
  KoorActivityPage({Key? key}) : super(key: key);

  @override
  State<KoorActivityPage> createState() => _KoorActivityPageState();
}

class _KoorActivityPageState extends State<KoorActivityPage> {
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
          future: AktivitasKoorController().getAktivitasKoor(),
          builder: (context, AsyncSnapshot snapshot) {

            print("ada data" + snapshot.hasData.toString());
            if (snapshot.hasData) {
              return snapshot.data.length != 0 ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    Column(
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
                                            var key = snapshot.data[index].id;
                                            AktivitasKoorController
                                                .deleteAktivitasKoor(key);
                                            setState(() {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: Text("Yakin")),
                                    ],
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
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
                                  Row(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: <InlineSpan>[
                                            WidgetSpan(
                                                child: Icon(Icons.location_on_outlined,
                                                  color: Colors.green, size: 15,)),
                                            TextSpan(
                                                text: snapshot
                                                    .data[index].jadwal.cleanArea),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text.rich(
                                        TextSpan(
                                          children: <InlineSpan>[
                                            WidgetSpan(
                                                child: Icon(Icons.calendar_today,
                                                    color: Colors.green, size: 15)),
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
                                    ],
                                  ),
                                  SizedBox(height: 1),
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
                    );


                },
              ): Center(
                child: Text("Tidak ada aktivitas"),
              );
            } else {
              return Center(
                child: Text("Tidak ada aktivitas"),
              );
            }
          }),
    );
  }

}
