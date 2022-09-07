import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class TambahAcara extends StatefulWidget {
  TambahAcara({Key? key}) : super(key: key);

  @override
  State<TambahAcara> createState() => _TambahAcaraState();
}

class _TambahAcaraState extends State<TambahAcara> {
  final ref = FirebaseDatabase.instance.ref().child('petugas');
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Laporan',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                trailing: Wrap(
                  children: <Widget> [
                    new IconButton(
                      icon : Icon(Icons.add, color: Colors.green),
                      onPressed: () {
                        // launch('tel:${snapshot.child('telp').value.toString()}');
                      },
                    ),
                  ],
                ),
                title: const Text(
                  'Tambah Laporan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            )
          ],
        )
    );
  }
}