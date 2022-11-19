import 'package:boilerplate/models/laporan_petugas.dart';
import 'package:boilerplate/ui/image/image_preview.dart';
import 'package:boilerplate/ui/image/image_preview_activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailLaporanPetugas extends StatefulWidget {
  String? cleanArea;
  String? name;
  List<PetugasActivity>? listAktivitasPetugas;
  DetailLaporanPetugas(
      {Key? key,
      required this.listAktivitasPetugas,
      required this.cleanArea,
      required this.name})
      : super(key: key);

  @override
  State<DetailLaporanPetugas> createState() => _DetailLaporanPetugasState();
}

class _DetailLaporanPetugasState extends State<DetailLaporanPetugas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name!),
          backgroundColor: Colors.green,
        ),
        body: ListView.builder(
          itemCount: widget.listAktivitasPetugas!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                widget.cleanArea!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                //convert dari string ke date
                DateFormat.yMMMMEEEEd().format(
                    DateTime.parse(widget.listAktivitasPetugas![index].date!)),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.task_alt_outlined, color: Colors.green),
              ),
              trailing: new Wrap(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15, right: 8),
                    child: Text(
                      //Time format
                      DateFormat('HH:mm').format(DateTime.parse(
                          widget.listAktivitasPetugas![index].time!)),
                    ),
                  ),
                  new Container(
                    child: new IconButton(
                      icon: new Icon(Icons.camera_front, color: Colors.orange),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImagePreviewActivity(
                                    image: widget
                                        .listAktivitasPetugas![index].photo,
                                  )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
