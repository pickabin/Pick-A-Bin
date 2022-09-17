import 'package:boilerplate/data/service/auth_service.dart';
import 'package:boilerplate/ui/activity/activity_page.dart';
import 'package:boilerplate/ui/authentication/role_selection.dart';
import 'package:boilerplate/ui/laporan/laporan_page.dart';
import 'package:boilerplate/ui/profile/profile_activity_petugas.dart';
import 'package:boilerplate/ui/profile/profile_petugas_page.dart';
import 'package:boilerplate/ui/schedule/jadwal_khusus_page.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:boilerplate/ui/update_profile/update_petugas_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePetugasMain extends StatefulWidget {
  const ProfilePetugasMain({Key? key}) : super(key: key);

  @override
  State<ProfilePetugasMain> createState() => _ProfilePetugasMainState();
}

class _ProfilePetugasMainState extends State<ProfilePetugasMain> {
  //Read data once from Realtime Database
  final ref = FirebaseDatabase.instance.ref().child('petugas');
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile Saya',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: FutureBuilder(
          future: _getPrefs(),
          builder: (context, snapshot) {
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
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: snapshot.child('imageUrl').value != null
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        child: CircleAvatar(
                                            radius: 60,
                                            backgroundImage: NetworkImage(
                                              snapshot
                                                  .child('imageUrl')
                                                  .value
                                                  .toString(),
                                            )),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        child: CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.green,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/user_icon.png'),
                                            radius: 68,
                                          ),
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        snapshot.child('nama').value.toString(),
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.black)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.5),
                                      child: Text(
                                        snapshot.child('telp').value.toString(),
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 57, 57, 57),
                                            fontSize: 12.0,
                                            letterSpacing: 0.5,
                                            wordSpacing: 1),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.5),
                                      child: Text(
                                        snapshot
                                            .child('email')
                                            .value
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 57, 57, 57),
                                            fontSize: 12.0,
                                            letterSpacing: 0.5,
                                            wordSpacing: 1),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfilePetugasPage()));
                                },
                                child: Container(
                                    margin: EdgeInsets.only(left: 100),
                                    child: Icon(Icons.edit)),
                              ),
                            ],
                          ),
                          Container(
                            margin: new EdgeInsets.only(top: 5.0, right: 86.0),
                            width: 87,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 22, 22, 22),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5,
                                bottom: 5,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 10.0,
                                    backgroundColor:
                                        Color.fromARGB(255, 239, 240, 238),
                                    child: Icon(
                                      Icons.star_rounded,
                                      color: Colors.green,
                                      size: 19.0,
                                    ),
                                  ),
                                  Text(
                                    " Premium",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: new EdgeInsets.only(
                                top: 12.0, right: 7, left: 3),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, top: 5, bottom: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, bottom: 6.0),
                                    child: Text(
                                      "Akun Anda sudah terverifikasi, jadi lebih aman.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 100,
                                    height: 20,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text('Periksa'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black38,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ))))
                              ],
                            ),
                            width: 340,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text("Akun",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: 35.0,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.book_rounded,
                                  ),
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  title: const Text('Aktivitas'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileActivityPetugas()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child:
                                    Divider(thickness: 1, color: Colors.black),
                              ),
                              Container(
                                height: 35.0,
                                child: ListTile(
                                  leading: Icon(Icons.report_rounded),
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  title: const Text('Lapor'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LaporanPage()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child:
                                    Divider(thickness: 1, color: Colors.black),
                              ),
                              Container(
                                height: 35.0,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.calendar_today_rounded,
                                  ),
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  title: const Text('Jadwal Khusus'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JadwalKhususPage()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child:
                                    Divider(thickness: 1, color: Colors.black),
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
                                child:
                                    Divider(thickness: 1, color: Colors.black),
                              ),
                              Container(
                                height: 35.0,
                                child: ListTile(
                                  leading: Icon(Icons.star_half_rounded),
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  title: const Text('Beri rating'),
                                  onTap: () async {
                                    if (await canLaunch(
                                        'https://play.google.com/store/apps/details?id=com.pickabin.pickabin_app')) {
                                      await launch(
                                          'https://play.google.com/store/apps/details?id=com.pickabin.pickabin_app');
                                    } else {
                                      throw 'Could not launch URL';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child:
                                    Divider(thickness: 1, color: Colors.black),
                              ),
                              Container(
                                height: 35.0,
                                child: ListTile(
                                  leading: Icon(Icons.person_add_alt_1_rounded),
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  title:
                                      const Text('Ajak teman pakai pick a bin'),
                                  onTap: () {
                                    Share.share(
                                        'https://play.google.com/store/apps/details?id=com.pickabin.pickabin_app');
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child:
                                    Divider(thickness: 1, color: Colors.black),
                              ),
                              Container(
                                height: 35.0,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.notifications_active_rounded,
                                  ),
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  title: const Text('Notifikasi'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ActivityPage()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child:
                                    Divider(thickness: 1, color: Colors.black),
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
                                child:
                                    Divider(thickness: 1, color: Colors.black),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 100),
                                height: 35.0,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.logout,
                                  ),
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                  title: const Text('Logout'),
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    // prefs.remove('uid');
                                    prefs.clear();
                                    authService.logout();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RoleSelection()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

Future<String?> _getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  return email;
}
