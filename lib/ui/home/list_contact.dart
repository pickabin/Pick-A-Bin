import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class ListContactPage extends StatefulWidget {
  ListContactPage({Key? key}) : super(key: key);

  @override
  State<ListContactPage> createState() => _ListContactPageState();
}

class _ListContactPageState extends State<ListContactPage> {
  final ref = FirebaseDatabase.instance.ref().child('warga');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'List Contact',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          leading: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff00783E),
            ),
            label: const Text(
              'Back',
              style: TextStyle(color: Color(0xff00783E)),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0, primary: Colors.transparent),
          ),
        ),
        body: FirebaseAnimatedList(
            query: ref.orderByChild('penanggungJawab'),
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                          title: Text(
                            "${snapshot.child('penanggungJawab').value.toString()}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(snapshot.child('telp').value.toString()),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/images/user_icon.png"),
                          ),
                          trailing: Wrap(
                        children: <Widget> [
                          new IconButton(
                            icon : Icon(Icons.chat, color: Colors.green),
                            onPressed: () async{
                              final _text = 'sms:${snapshot.child('telp').value.toString()}';
                              // launch('tel:${snapshot.child('telp').value.toString()}');
                                  if(await canLaunch(_text)) {
                                    launch(_text);
                                  } 
                            },
                            ),
                           new IconButton(
                            icon : Icon(Icons.phone,color: Colors.green),
                            onPressed: () {
                              // launch('tel:${snapshot.child('telp').value.toString()}');
                                  FlutterPhoneDirectCaller.callNumber(
                                      snapshot.child('telp').value.toString());
                            },
                            ),
                        ],
                      ),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      )
                  ],
                );
            }
        )
    );
  }
}
