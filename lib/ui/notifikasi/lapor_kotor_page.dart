import 'package:boilerplate/controllers/lapor_kotor_controller.dart';
import 'package:boilerplate/ui/image/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:intl/intl.dart';

class LaporKotorPage extends StatefulWidget {
  LaporKotorPage({Key? key}) : super(key: key);

  @override
  State<LaporKotorPage> createState() => _LaporKotorPageState();
}

class _LaporKotorPageState extends State<LaporKotorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: LaporKotorController().getLaporKotor(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return snapshot.data.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.lightGreen,
                                    child: Icon(
                                      Icons.list_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Container(
                                    padding: EdgeInsets.only(top: 15),
                                    child: Text(
                                      snapshot.data[index].cleanArea,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Text(
                                      snapshot.data[index].deskripsi + '\n'),
                                  trailing: Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Wrap(
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.image),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImagePreview(
                                                          image: snapshot
                                                              .data[index]
                                                              .photo,
                                                        )),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.black),
                              ],
                            ),
                          );
                        })
                    : Center(child: Text('Tidak ada laporan'));
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
