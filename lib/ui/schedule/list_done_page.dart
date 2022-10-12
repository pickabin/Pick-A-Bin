import 'dart:async';

import 'package:boilerplate/ui/schedule/detail_list_done.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDonePage extends StatelessWidget {
  ListDonePage({Key? key}) : super(key: key);
  final fb = FirebaseDatabase.instance;
  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('jadwal').orderByChild('status').equalTo(true);

    return Scaffold(
        body: ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            "Budi",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Ruang C102"),
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_icon.png"),
          ),
          trailing: new Wrap(
            children: <Widget>[
              new Container(
                child: new IconButton(
                  icon: new Icon(Icons.list_alt_outlined, color: Colors.orange),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailListDone()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
