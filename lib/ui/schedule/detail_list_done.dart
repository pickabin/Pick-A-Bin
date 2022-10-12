import 'dart:async';

import 'package:boilerplate/ui/image/image_preview.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailListDone extends StatefulWidget {
  const DetailListDone({Key? key}) : super(key: key);

  @override
  State<DetailListDone> createState() => _DetailListDoneState();
}

class _DetailListDoneState extends State<DetailListDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Budi"),
          backgroundColor: Colors.green,
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "C102",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("11/11/2022"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.task_alt_outlined, color: Colors.green),
              ),
              trailing: new Wrap(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15, right: 8),
                    child: Text("10.20"),
                  ),
                  new Container(
                    child: new IconButton(
                      icon: new Icon(Icons.camera_front, color: Colors.orange),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => ImagePreview()),
                        // );
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
