import 'package:boilerplate/data/service/auth_service.dart';
import 'package:boilerplate/ui/activity/koor_activity_page.dart';
//import 'package:boilerplate/ui/profile/profile_warga_page.dart';
//import 'package:boilerplate/ui/update_profile/update_petugas_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PengaturanMain extends StatefulWidget {
  const PengaturanMain({Key? key}) : super(key: key);

  @override
  State<PengaturanMain> createState() => _PengaturanMainState();
}

class _PengaturanMainState extends State<PengaturanMain> {
  //Read data once from Realtime Database
  final ref = FirebaseDatabase.instance.ref().child('warga');
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: FutureBuilder(
        future: _getPrefs(),
        builder: ((context, snapshot){
          if (snapshot.hasData) {
            return FirebaseAnimatedList(
                shrinkWrap: true,
                query: ref.orderByChild('email').equalTo("${snapshot.data}"),
                itemBuilder: (context, snapshot, animation, index) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text("Pengaturan akun",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 35.0,
                              child: ListTile(
                                leading: Icon(
                                  Icons.notifications_active_rounded,
                                ),
                                title: const Text('Notifikasi'),
                                trailing:
                                Icon(Icons.arrow_forward_ios_outlined),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KoorActivityPage()));
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 70.0),
                              child: Divider(thickness: 1, color: Colors.black),
                            ),
                            Container(
                              height: 35.0,
                              child: ListTile(
                                leading: Icon(
                                  Icons.language,
                                ),
                                trailing:
                                Icon(Icons.arrow_forward_ios_outlined),
                                title: const Text('Pilihan Bahasa'),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text(
                                          "Fitur ini belum tersedia"),
                                      content: const Text(
                                          "Fitur ini akan segera hadir di versi selanjutnya"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            color: Colors.green,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text(
                                              "Oke",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 70.0),
                              child: Divider(thickness: 1, color: Colors.black),
                            ),
                            Container(
                              height: 35.0,
                              child: ListTile(
                                leading: Icon(
                                  Icons.security,
                                ),
                                trailing:
                                Icon(Icons.arrow_forward_ios_outlined),
                                title: const Text('Keamanan akun'),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text(
                                          "Fitur ini belum tersedia"),
                                      content: const Text(
                                          "Fitur ini akan segera hadir di versi selanjutnya"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            color: Colors.green,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text(
                                              "Oke",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 70.0),
                              child: Divider(thickness: 1, color: Colors.black),
                            ),
                            Container(
                              height: 35.0,
                              child: ListTile(
                                leading: Icon(
                                  Icons.question_mark_rounded,
                                ),
                                trailing:
                                Icon(Icons.arrow_forward_ios_outlined),
                                title: const Text('Bantuan & Info'),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text(
                                          "Fitur ini belum tersedia"),
                                      content: const Text(
                                          "Fitur ini akan segera hadir di versi selanjutnya"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            color: Colors.green,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text(
                                              "Oke",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 70.0),
                              child: Divider(thickness: 1, color: Colors.black),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}

Future<String?> _getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  return email;
}
