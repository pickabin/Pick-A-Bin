import 'package:boilerplate/controllers/aktivitas_petugas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:intl/intl.dart';


class PetugasActivityPage extends StatefulWidget {
  PetugasActivityPage({Key? key}) : super(key: key);

  @override
  State<PetugasActivityPage> createState() => _PetugasActivityPageState();
}

class _PetugasActivityPageState extends State<PetugasActivityPage> {

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
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: ListTile(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(snapshot.data[index].status == null ? "Sedang Ditinjau" : snapshot.data[index].status == 2 ? "Feedback" : "Selesai", textAlign: TextAlign.justify,),
                                    content: Text(snapshot.data[index].status == null ? "Laporan yang Anda kirimkan sedang ditinjau oleh Koordinator" :
                                    snapshot.data[index].status == 2 ? snapshot.data[index].feedback : "Laporan yang Anda kirimkan telah dikonfirmasi oleh Koordinator"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Tutup")),
                                      snapshot.data[index].status == 2 ? TextButton(
                                          onPressed: () {
                                            AktivitasPetugasController()
                                                .updateStatusAktivitasPetugas(snapshot.data[index].id)
                                                .then((value) {
                                              setState(() {
                                                Navigator.of(context).pop();
                                              });
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      content:
                                                      Text("Berhasil Update Status")));
                                            });
                                          },
                                          child: Text("Selesaikan")) : Container()
                                    ],
                                  );
                                });
                          },
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
                              Container(
                                padding: EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: snapshot.data[index].status == null ? Colors.orange :
                                  snapshot.data[index].status == 1 ? Colors.green : Colors.red,
                                ),
                                child: Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: snapshot.data[index].status == null ? "Sedang ditinjau" :
                                          snapshot.data[index].status == 1 ? "Selesai" : "Lihat feedback",
                                          style: TextStyle(color: Colors.white)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundImage:
                            AssetImage("assets/images/activity_icon.png"),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Divider(color: Colors.black),
                    ],
                  );
                },
              ) : Center(child: Text("Tidak ada aktivitas"));
            } else {
              return Center(
                child: ListTileShimmer(),
              );
            }
          },
        ));
  }
}
