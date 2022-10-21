import 'package:boilerplate/controllers/petugas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ListContactPetugasPage extends StatefulWidget {
  ListContactPetugasPage({Key? key}) : super(key: key);
  

  @override
  State<ListContactPetugasPage> createState() => _ListContactPetugasPageState();
}

class _ListContactPetugasPageState extends State<ListContactPetugasPage> {
  // final ref = FirebaseDatabase.instance.ref().child('petugas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'List Petugas',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
        ),
        body: FutureBuilder(
            future: PetugasController().getPetugas(),
            builder: (context, AsyncSnapshot snapshot) {
             
              if (snapshot.hasData) {
                
                return snapshot.data.length != 0 ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListTile(
                              trailing: Wrap(
                                children: <Widget>[
                                  new IconButton(
                                    icon: Icon(Icons.chat, color: Colors.green),
                                    onPressed: () async {
                                      final _text =
                                          'sms:${snapshot.data[index].user.phone}';
                                      // launch('tel:${snapshot.child('telp').value.toString()}');
                                      if (await canLaunch(_text)) {
                                        launch(_text);
                                      }
                                    },
                                  ),
                                  new IconButton(
                                    icon:
                                        Icon(Icons.phone, color: Colors.green),
                                    onPressed: () {
                                      // launch('tel:${snapshot.child('telp').value.toString()}');
                                      FlutterPhoneDirectCaller.callNumber(
                                          snapshot.data[index].user.phone);
                                    },
                                  ),
                                ],
                              ),
                              title: Text(
                                snapshot.data[index].user.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: snapshot.data[index].user.phone != null ? Text(snapshot.data[index].user.phone) : Text('No mobile number'),
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/user_icon.png"),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          )
                        ],
                      );
                    }) : Center(child: Text('Belum ada petugas yang terdaftar'));
              } else {
                return ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context,index) {
                    return ListTileShimmer();
                  }
                );
              }
            }));
  }
}
