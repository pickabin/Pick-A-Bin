import 'package:boilerplate/data/repository/maps_utils.dart';
import 'package:boilerplate/ui/maps/detail_location_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MapsUserPage extends StatefulWidget {
  const MapsUserPage({Key? key}) : super(key: key);

  @override
  State<MapsUserPage> createState() => _MapsUserPageState();
}

class _MapsUserPageState extends State<MapsUserPage> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('lokasi').snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Text('Maps User'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView(
                padding: EdgeInsets.only(top: 20),
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Column(
                    children: [
                      ListTile(
                        title: Text(data['penanggungJawab']),
                        subtitle: Text(
                          data['alamat'],
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/user_icon.png'),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.subdirectory_arrow_right_sharp,
                            color: Colors.green,
                          ),
                          onPressed: () {
                           MapsUtils.openMap(data['lat'], data['long']);
                          },
                        ),
                      ),
                      Divider()
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ));
  }
}
