import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final ref = FirebaseDatabase.instance
      .ref()
      .child('jadwal')
      .orderByChild('date')
      .equalTo(DateFormat('dd/MM/yyyy').format(DateTime.now()).toString());

  // bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                bool isChecked = snapshot.child('status').value as bool;
                // print(snapshot.child('alamat').value.toString());
                // print(date);
                return InkWell(
                  child: Column(
                    children: <Widget>[
                      snapshot.child('status').value.toString() == 'false'
                          ? CheckboxListTile(
                              title: Text(
                                snapshot.child('instansi').value.toString() +
                                    " - " +
                                    snapshot
                                        .child('penanggungJawab')
                                        .value
                                        .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  snapshot.child('alamat').value.toString()),
                              secondary: CircleAvatar(
                                  backgroundImage: AssetImage(
                                "assets/images/building_icon.png",
                              )),
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              selected: isChecked,
                              value: isChecked,
                              onChanged: (bool? value) async {
                                setState(() {
                                  isChecked = value!;
                                });
                                // await new Future.delayed(const Duration(seconds: 2));
                                var key = snapshot.key;
                                DatabaseReference up = FirebaseDatabase.instance
                                    .ref("jadwal/$key");
                                up.update({
                                  "status": true,
                                   "tglSelesai": DateFormat('dd/MM/yyyy')
                                      .format(DateTime.now())
                                      .toString(),
                                  "waktuSelesai": DateFormat('HH:mm')
                                      .format(DateTime.now())
                                      .toString(),
                                });
                              })
                          : Container()
                    ],
                  ),
                );
              }),
        ));
  }
}
