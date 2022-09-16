import 'package:boilerplate/ui/home/list_contact_page.dart';
import 'package:boilerplate/ui/maps/maps_main_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePetugasPage extends StatefulWidget {
  const HomePetugasPage({Key? key}) : super(key: key);

  @override
  State<HomePetugasPage> createState() => _HomePetugasPageState();
}

class _HomePetugasPageState extends State<HomePetugasPage> {
  final ref = FirebaseDatabase.instance
      .ref()
      .child('jadwal')
      .orderByChild('date')
      .equalTo(DateFormat('dd/MM/yyyy').format(DateTime.now()).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: ListView(
          children: <Widget>[
            const Text(
              "Hi, Petugas!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              "assets/images/home.jpg",
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: const Text(
                  "Aktivitas",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapsMainPage()))
                      },
                      child: Container(
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.location_on_outlined,
                              size: 70,
                              color: Colors.green,
                            )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.green, spreadRadius: 2),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Maps \n",
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ListContactPage()));
                      },
                      child: Container(
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.contacts_outlined,
                              size: 70,
                              color: Colors.green,
                            )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.green, spreadRadius: 2),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: const Text(
                          "Kontak",
                          textAlign: TextAlign.center,
                        ))
                  ],
                )
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 30, bottom: 10),
                child: const Text(
                  "Jadwal Terbaru",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: FirebaseAnimatedList(
                  shrinkWrap: true,
                  //query status sama dengan
                  query: ref,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    // bool isChecked = snapshot.child('status').value as bool;

                    return Column(
                      children: <Widget>[
                        snapshot.child('status').value.toString() == 'false'
                            ? ListTile(
                                title: Text(
                                  snapshot.child('instansi').value.toString() +
                                      " - " +
                                      snapshot
                                          .child('penanggungJawab')
                                          .value
                                          .toString(),
                                ),
                                subtitle: Text(
                                  snapshot.child('alamat').value.toString(),
                                ),
                                leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                  "assets/images/building_icon.png",
                                )),
                                trailing: Text(
                                  snapshot.child('date').value.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 241, 96, 96),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: const EdgeInsets.only(top: 10),
                                child: ListTile(
                                  title: Text(
                                    snapshot
                                            .child('instansi')
                                            .value
                                            .toString() +
                                        " - " +
                                        snapshot
                                            .child('penanggungJawab')
                                            .value
                                            .toString(),
                                  ),
                                  subtitle: Text("Sampah sudah diambil",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                    "assets/images/building_icon.png",
                                  )),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        snapshot
                                            .child('tglSelesai')
                                            .value
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot
                                            .child('waktuSelesai')
                                            .value
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
