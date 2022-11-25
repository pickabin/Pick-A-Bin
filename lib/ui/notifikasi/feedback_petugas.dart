import 'package:boilerplate/controllers/aktivitas_petugas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:intl/intl.dart';

class FeedbackPetugas extends StatefulWidget {
  FeedbackPetugas({Key? key}) : super(key: key);

  @override
  State<FeedbackPetugas> createState() => _FeedbackPetugasState();
}

class _FeedbackPetugasState extends State<FeedbackPetugas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: AktivitasPetugasController().getAktivitasPetugas(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return snapshot.data.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return snapshot.data[index].feedback != null
                              ? Container(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: ListTile(
                                          title: Text.rich(
                                            TextSpan(
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text: snapshot.data[index]
                                                      .jadwal.cleanArea,
                                                ),
                                              ],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          subtitle: Text.rich(
                                            TextSpan(
                                              children: <InlineSpan>[
                                                // WidgetSpan(
                                                //     child: Icon(
                                                //         Icons.location_on_outlined,
                                                //         color: Colors.green)),
                                                TextSpan(
                                                    text: snapshot
                                                        .data[index].feedback),
                                              ],
                                            ),
                                          ),
                                          leading: CircleAvatar(
                                            child: Icon(
                                              Icons.warning_amber,
                                              color: Colors.white,
                                            ),
                                            backgroundColor: Color(0xffEF7D31),
                                          ),
                                        ),
                                      ),
                                      Divider(color: Colors.black),
                                    ],
                                  ),
                                )
                              : Container();
                        })
                    : Center(child: Text('Tidak ada feedback'));
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
