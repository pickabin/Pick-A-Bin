import 'package:boilerplate/controllers/petugas_controller.dart';
import 'package:boilerplate/data/service/auth_service.dart';
import 'package:boilerplate/models/petugas.dart';
import 'package:boilerplate/ui/activity/petugas_activity_page.dart';
import 'package:boilerplate/ui/authentication/role_selection.dart';
import 'package:boilerplate/ui/home/list_contact_koor_page.dart';
import 'package:boilerplate/ui/laporan/laporan_page.dart';
import 'package:boilerplate/ui/profile/profile_detail_image.dart';
import 'package:boilerplate/ui/schedule/jadwal_khusus_koordinator.dart';
import 'package:boilerplate/ui/update_profile/update_petugas_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
// import variables global
import 'package:boilerplate/data/service/global.dart' as global;

class ProfilePetugasMain extends StatefulWidget {
  const ProfilePetugasMain({Key? key}) : super(key: key);

  @override
  State<ProfilePetugasMain> createState() => _ProfilePetugasMainState();
}

class _ProfilePetugasMainState extends State<ProfilePetugasMain> {
  //Read data once from Realtime Database
  // final ref = FirebaseDatabase.instance.ref().child('warga');
  late Future<List<Petugas>> futurePetugas;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    futurePetugas = PetugasController().getPetugasByUid();
  }

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               global.nama == null ? FutureBuilder<List<Petugas>>(
                  future: futurePetugas,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            global.idUser = snapshot.data[index].user.id;
                            global.nama = snapshot.data[index].user.name;
                            global.noHp = snapshot.data[index].user.phone;
                            global.email = snapshot.data[index].user.email;
                            global.alamat = snapshot.data[index].user.address;
                            global.photo = snapshot.data[index].user.photo;
                            return Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: snapshot.data[index].user.photo != null
                                      ? GestureDetector(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.20,
                                            child: CircleAvatar(
                                              radius: 60,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      snapshot.data[index].user
                                                          .photo),
                                            ),
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
                                                                .photo)));
                                          },
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.20,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          snapshot.data[index].user.name != null
                                              ? snapshot.data[index].user.name
                                              : 'Nama',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.5),
                                        child: snapshot
                                                    .data[index].user.phone !=
                                                null
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
                                        padding:
                                            const EdgeInsets.only(top: 2.5),
                                        child: Text(
                                          snapshot.data[index].user.email,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 57, 57, 57),
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
                                                UpdatePetugasPage(
                                                  name: snapshot
                                                      .data[index].user.name,
                                                  phone: snapshot
                                                      .data[index].user.phone,
                                                  email: snapshot
                                                      .data[index].user.email,
                                                  imageUrl: snapshot
                                                      .data[index].user.photo,
                                                  address: snapshot
                                                      .data[index].user.address,
                                                  id: snapshot
                                                      .data[index].user.id,
                                                )));
                                  },
                                ),
                              ],
                            );
                          });
                    } else {
                      return ListTileShimmer();
                    }
                  }) : profilePetugas(context),
                      global.noHp != null &&
                      global.noHp != "null" &&
                      global.alamat != null &&
                      global.alamat != "null"
                  ? Container(
                      margin: new EdgeInsets.only(top: 12.0, right: 7, left: 3),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 5, bottom: 5),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 6.0),
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
                                                UpdatePetugasPage(
                                                  name: global.nama,
                                                  phone: global.noHp,
                                                  email: global.email,
                                                  imageUrl: global.photo,
                                                  address: global.alamat,
                                                  id: global.idUser,
                                                )));
                                  },
                                  child: Text('Periksa'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black38,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ))))
                        ],
                      ),
                      width: 340,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    )
                  : Container(
                      margin: new EdgeInsets.only(
                          top: 12.0,
                          right: MediaQuery.of(context).size.width * 0.02,
                          left: MediaQuery.of(context).size.width * 0.02),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 4, left: 10, top: 5, bottom: 5),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 6.0),
                              child: Text(
                                "Akun Anda belum terverifikasi, silahkan lengkapi profil.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.0235),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: MediaQuery.of(context).size.height * 0.02,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdatePetugasPage(
                                                  name: global.nama,
                                                  phone: global.noHp,
                                                  email: global.email,
                                                  imageUrl: global.photo,
                                                  address: global.alamat,
                                                  id: global.idUser,
                                                )));
                                  },
                                  child: Text('Verifikasi',
                                      style: TextStyle(fontSize: 10.0)),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black38,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ))))
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
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
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      title: const Text('Aktivitas'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PetugasActivityPage()));
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
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      title: const Text('Kontak Koordinator'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListContactKoorPage()));
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
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
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
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             PengaturanMain()));
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Fitur ini belum tersedia"),
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
                                    style: TextStyle(color: Colors.white),
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
                      leading: Icon(Icons.star_half_rounded),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
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
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      title: const Text('Ajak teman pakai pick a bin'),
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
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      title: const Text('Logout'),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        // prefs.remove('uid');
                        prefs.clear();
                        authService.logout();
                        global.nama = null;
                        global.email = null;
                        global.noHp = null;
                        global.alamat = null;
                        global.photo = null;
                        global.code = null;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RoleSelection()));
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
        ));
  }
}

Widget profileUser(BuildContext context) {
  return Row(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: global.photo != null
            ? GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        CachedNetworkImageProvider(global.photo.toString()),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileDetailImage(image: global.photo)));
                },
              )
            : Container(
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.2,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user_icon.png'),
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
            Text(global.nama.toString(),
                style: TextStyle(fontSize: 17, color: Colors.black)),
            Padding(
              padding: const EdgeInsets.only(top: 2.5),
              child: global.noHp != null
                  ? Text(
                      global.noHp.toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 57, 57, 57),
                          fontSize: 12.0,
                          letterSpacing: 0.5,
                          wordSpacing: 1),
                    )
                  : Text(
                      'No Phone',
                      style: TextStyle(
                          color: Color.fromARGB(255, 57, 57, 57),
                          fontSize: 12.0,
                          letterSpacing: 0.5,
                          wordSpacing: 1),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.5),
              child: Text(
                global.email.toString(),
                style: TextStyle(
                    color: Color.fromARGB(255, 57, 57, 57),
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
                  builder: (context) => UpdatePetugasPage(
                        name: global.nama,
                        phone: global.noHp,
                        email: global.email,
                        imageUrl: global.photo,
                        address: global.alamat,
                        id: global.idUser,
                      )));
        },
      ),
    ],
  );
}

// widget profile user
Widget profilePetugas(BuildContext context) {
  return Row(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: global.photo != null
            ? GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        CachedNetworkImageProvider(global.photo.toString()),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileDetailImage(image: global.photo)));
                },
              )
            : Container(
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.2,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user_icon.png'),
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
            Text(global.nama.toString(),
                style: TextStyle(fontSize: 17, color: Colors.black)),
            Padding(
              padding: const EdgeInsets.only(top: 2.5),
              child: global.noHp != null
                  ? Text(
                      global.noHp.toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 57, 57, 57),
                          fontSize: 12.0,
                          letterSpacing: 0.5,
                          wordSpacing: 1),
                    )
                  : Text(
                      'No Phone',
                      style: TextStyle(
                          color: Color.fromARGB(255, 57, 57, 57),
                          fontSize: 12.0,
                          letterSpacing: 0.5,
                          wordSpacing: 1),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.5),
              child: Text(
                global.email.toString(),
                style: TextStyle(
                    color: Color.fromARGB(255, 57, 57, 57),
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
                  builder: (context) => UpdatePetugasPage(
                        name: global.nama.toString(),
                        phone: global.noHp.toString(),
                        email: global.email.toString(),
                        imageUrl: global.photo.toString(),
                        address: global.alamat.toString(),
                        id: global.idUser,
                      )));
        },
      ),
    ],
  );
}

Future<String?> _getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uid = prefs.getString('uid');
  return uid;
}
