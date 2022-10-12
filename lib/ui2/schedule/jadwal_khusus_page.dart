import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JadwalKhususPage extends StatefulWidget {
  const JadwalKhususPage({Key? key}) : super(key: key);

  @override
  State<JadwalKhususPage> createState() => _JadwalKhususPageState();
}

class _JadwalKhususPageState extends State<JadwalKhususPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('jadwal_khusus').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Khusus'),
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
                      trailing: CircleAvatar(
                          backgroundImage: AssetImage(
                        "assets/images/building_icon.png",
                      )),
                      title: Text(data['jenis_acara']),
                      subtitle: Text(data['lokasi']),
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
}
