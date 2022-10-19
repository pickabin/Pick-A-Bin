import 'package:boilerplate/controllers/laporan_petugas_controller.dart';
import 'package:boilerplate/models/laporan_petugas.dart';
import 'package:boilerplate/ui/schedule/detail_list_done.dart';
import 'package:flutter/material.dart';

class LaporanPetugasPage extends StatefulWidget {
  LaporanPetugasPage({Key? key}) : super(key: key);

  @override
  State<LaporanPetugasPage> createState() => _LaporanPetugasPageState();
}

class _LaporanPetugasPageState extends State<LaporanPetugasPage> {
  // final fb = FirebaseDatabase.instance;

  // final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    // final ref = fb.ref().child('jadwal').orderByChild('status').equalTo(true);

    return Scaffold(
        body: FutureBuilder(
      future: LaporanPetugasController().getAktivitasPetugasByCode(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  snapshot.data[index].user.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(snapshot.data[index].cleanArea),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user_icon.png"),
                ),
                trailing: new Wrap(
                  children: <Widget>[
                    new Container(
                      child: new IconButton(
                        icon: new Icon(Icons.list_alt_outlined,
                            color: Colors.orange),
                        onPressed: () {
                          //type List<AktivitasPetugas>
                          // print("Detail" + snapshot.data[index].aktivitasPetugas);
                          List<PetugasActivity>? listAktivitasPetugas =
                              snapshot.data[index].petugasActivity;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailLaporanPetugas(
                                    listAktivitasPetugas: listAktivitasPetugas, 
                                    cleanArea: snapshot.data[index].cleanArea,
                                    name: snapshot.data[index].user.name
                              )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
}
