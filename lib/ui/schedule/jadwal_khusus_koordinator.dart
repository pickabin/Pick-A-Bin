import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JadwalKhususKoordinator extends StatefulWidget {
  final String? uid;
  JadwalKhususKoordinator({Key? key, required this.uid}) : super(key: key);

  @override
  State<JadwalKhususKoordinator> createState() => _JadwalKhususKoordinatorState();
}

class _JadwalKhususKoordinatorState extends State<JadwalKhususKoordinator> {
  
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('jadwal_khusus').where('uid_akun', isEqualTo: widget.uid.toString()).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Acara'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                    ListTile(
                      trailing: data['status'].toString() == 'false' ? Icon(Icons.cancel, color: Colors.red,) : Icon(Icons.check, color: Colors.green,),
                      title: Text(data['jenis_acara']),
                      subtitle: Text(data['lokasi']),
                      leading: CircleAvatar(
                          backgroundImage: AssetImage(
                        "assets/images/building_icon.png",
                      )),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
  // Future<String?> _getPrefsUid() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? uid = prefs.getString('uid');
  //   return uid;
  // }
}