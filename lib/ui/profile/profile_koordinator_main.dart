import 'package:boilerplate/controllers/koor_gedung_controller.dart';
import 'package:boilerplate/data/service/auth_service.dart';
import 'package:boilerplate/ui/activity/koor_activity_page.dart';
import 'package:boilerplate/ui/authentication/role_selection.dart';
import 'package:boilerplate/ui/home/list_contact_petugas_page.dart';
import 'package:boilerplate/ui/laporan/laporan_page.dart';
import 'package:boilerplate/ui/profile/pengaturan_akun.dart';
import 'package:boilerplate/ui/profile/profile_detail_image.dart';
import 'package:boilerplate/ui/notifikasi/notif_acara.dart';
import 'package:boilerplate/ui/update_profile/update_koordinator_page.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class ProfileKoordinatorMain extends StatefulWidget {
  const ProfileKoordinatorMain({Key? key}) : super(key: key);

  @override
  State<ProfileKoordinatorMain> createState() => _ProfileKoordinatorMainState();
}

class _ProfileKoordinatorMainState extends State<ProfileKoordinatorMain> {
  //Read data once from Realtime Database
  // final ref = FirebaseDatabase.instance.ref().child('warga');
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
        elevation: 0,
      ),
      body: FutureBuilder(
        future: KoorGedungController().getKoorByUid(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: snapshot.data[index].user.photo != null
                                  ? GestureDetector(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: CircleAvatar(
                                            radius: 60,
                                            backgroundImage: NetworkImage(
                                                snapshot.data[index].user.photo
                                                    .toString())),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileDetailImage(
                                                        image: snapshot
                                                            .data[index]
                                                            .user
                                                            .photo
                                                            .toString())));
                                      },
                                    )
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      snapshot.data[index].user.name.toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black)),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.5),
                                    child:
                                        snapshot.data[index].user.phone != null
                                            ? Text(
                                                snapshot.data[index].user.phone
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 57, 57, 57),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.5,
                                                    wordSpacing: 1),
                                              )
                                            : Text(
                                                'No Phone',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 57, 57, 57),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.5,
                                                    wordSpacing: 1),
                                              ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.5),
                                    child: Text(
                                      snapshot.data[index].user.email
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
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Icon(Icons.edit),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateKoordinatorPage(
                                              name: snapshot
                                                  .data[index].user.name
                                                  .toString(),
                                              phone: snapshot
                                                  .data[index].user.phone,
                                              email: snapshot
                                                  .data[index].user.email
                                                  .toString(),
                                              imageUrl: snapshot
                                                  .data[index].user.photo
                                                  .toString(),
                                              address: snapshot
                                                  .data[index].user.address,
                                              id: snapshot.data[index].user.id,
                                            )));
                              },
                            ),
                          ],
                        ),
                        snapshot.data[index].user.phone != null && 
                           snapshot.data[index].user.phone != "null" &&
                                snapshot.data[index].user.address != null && 
                                  snapshot.data[index].user.address != "null"
                            ? Container(
                                margin: new EdgeInsets.only(
                                    top: 12.0, right: 7, left: 3),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          top: 5,
                                          bottom: 5),
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateKoordinatorPage(
                                                            name: snapshot
                                                                .data[index]
                                                                .user
                                                                .name
                                                                .toString(),
                                                            phone: snapshot
                                                                .data[index]
                                                                .user
                                                                .phone,
                                                            email: snapshot
                                                                .data[index]
                                                                .user
                                                                .email
                                                                .toString(),
                                                            imageUrl: snapshot
                                                                .data[index]
                                                                .user
                                                                .photo
                                                                .toString(),
                                                            address: snapshot
                                                                .data[index]
                                                                .user
                                                                .address,
                                                            id: snapshot
                                                                .data[index]
                                                                .user
                                                                .id,
                                                          )));
                                            },
                                            child: Text('Periksa'),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.black38,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ))))
                                  ],
                                ),
                                width: 340,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              )
                            : Container(
                                margin: new EdgeInsets.only(
                                    top: 12.0, right: MediaQuery.of(context).size.width * 0.02, left: MediaQuery.of(context).size.width * 0.02),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4,
                                          left: 10,
                                          top: 5,
                                          bottom: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6.0, bottom: 6.0),
                                        child: Text(
                                          "Akun Anda belum terverifikasi, silahkan lengkapi profil.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.0235),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateKoordinatorPage(
                                                            name: snapshot
                                                                .data[index]
                                                                .user
                                                                .name
                                                                .toString(),
                                                            phone: snapshot
                                                                .data[index]
                                                                .user
                                                                .phone,
                                                            email: snapshot
                                                                .data[index]
                                                                .user
                                                                .email
                                                                .toString(),
                                                            imageUrl: snapshot
                                                                .data[index]
                                                                .user
                                                                .photo
                                                                .toString(),
                                                            address: snapshot
                                                                .data[index]
                                                                .user
                                                                .address,
                                                            id: snapshot
                                                                .data[index]
                                                                .user
                                                                .id,
                                                          )));
                                            },
                                            child: Text('Verifikasi',
                                                style:
                                                    TextStyle(fontSize: 10.0)),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.black38,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ))))
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                    color: Colors.red,
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
                                leading: Icon(Icons.person_pin),
                                trailing:
                                    Icon(Icons.arrow_forward_ios_outlined),
                                title: const Text('Kontak Petugas'),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListContactPetugasPage()));
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
                                leading: Icon(Icons.calendar_today_rounded),
                                trailing:
                                    Icon(Icons.arrow_forward_ios_outlined),
                                title: const Text('Jadwal acara saya'),
                                onTap: () async {
                                  // SharedPreferences prefs =
                                  //     await SharedPreferences.getInstance();
                                  // final String? uid = prefs.getString('uid');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotifAcara()));
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
                                leading: Icon(Icons.report_rounded),
                                trailing:
                                    Icon(Icons.arrow_forward_ios_outlined),
                                title: const Text('Lapor'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LaporanPage()));
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
                                  Icons.settings,
                                ),
                                title: const Text('Pengaturan akun'),
                                trailing:
                                    Icon(Icons.arrow_forward_ios_outlined),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PengaturanMain()));
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
                              child: Divider(thickness: 1, color: Colors.black),
                            ),
                            Container(
                              height: 35.0,
                              child: ListTile(
                                leading: Icon(Icons.person_add_alt_1_rounded),
                                trailing:
                                    Icon(Icons.arrow_forward_ios_outlined),
                                title:
                                    const Text('Ajak teman pakai pick a bin'),
                                onTap: () async {
                                  Share.share(
                                      'https://play.google.com/store/apps/details?id=com.pickabin.pickabin_app');
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
            return Container(
              child: Column(
                children: [
                  //shimmer loading
                  ListTileShimmer(
                    hasCustomColors: true,
                    hasBottomBox: true,
                    colors: [
                      // light color
                      Color(0xFF4dabf5),
                    ],
                  ),
                  ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTileShimmer(
                        hasCustomColors: true,
                        colors: [
                          // light color
                          Color(0xFF4dabf5),
                        ],
                      );
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// Future<String?> _getPrefs() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? uid = prefs.getString('uid');
//   return uid;
// }
