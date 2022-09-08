import 'package:boilerplate/ui/activity/activity.dart';
import 'package:boilerplate/ui/activity/user_activity.dart';
import 'package:boilerplate/ui/home/daftar_petugas_page.dart';
import 'package:boilerplate/ui/home/detail_acara.dart';
import 'package:boilerplate/ui/home/home_petugas_page.dart';
import 'package:boilerplate/ui/home/home_warga.dart';
import 'package:boilerplate/ui/maps/maps_main_page.dart';
import 'package:boilerplate/ui/profile/profile_petugas.dart';
import 'package:boilerplate/ui/profile/profile_warga.dart';
import 'package:boilerplate/ui/schedule/tab_bar.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavbarPage extends StatefulWidget {
  @override
  _NavbarPageState createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
// @override
// void initState() async {
//   super.initState();
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? rule = prefs.getString('role');
// }

  int selectedPage = 0;

  // final _pageOptionsPetugas = [
  //   HomePetugasPage(),
  //   StackOver(),
  //   ActivityPage(),
  //   ProfilePetugasPage(),
  // ];

  // final _pageOptionsWarga = [
  //   HomeWarga(),
  //   DaftarPetugasPage(),
  //   AktifitasWarga(),
  //   ProfileWargaPage(),
  // ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getRole(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return CurvedNavBar(
            actionButton: CurvedActionBar(
              onTab: (value) {
                /// perform action here
                snapshot.data == 'petugas'
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapsMainPage()))
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DetailAcara()));
              },
              activeIcon: Container(
                padding: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: snapshot.data == "petugas"
                    ? Icon(
                        Icons.location_on_outlined,
                        size: 45,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.add_alert_rounded,
                        size: 45,
                        color: Colors.white,
                      ),
              ),
              inActiveIcon: Container(
                padding: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: snapshot.data == "petugas"
                    ? Icon(
                        Icons.location_on_outlined,
                        size: 45,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.add_alert_rounded,
                        size: 45,
                        color: Colors.white,
                      ),
              ),
              // text: "Maps",
            ),
            activeColor: Colors.green,
            navBarBackgroundColor: Colors.white,
            inActiveColor: Colors.black45,
            appBarItems: [
              FABBottomAppBarItem(
                  activeIcon: Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  inActiveIcon: Icon(
                    Icons.home,
                    color: Colors.black26,
                  ),
                  text: 'Home'),
              FABBottomAppBarItem(
                  activeIcon: Icon(
                    snapshot.data == 'petugas'
                        ? Icons.calendar_month_outlined
                        : Icons.perm_contact_calendar_outlined,
                    color: Colors.green,
                  ),
                  inActiveIcon: Icon(
                    snapshot.data == 'petugas'
                        ? Icons.calendar_month_outlined
                        : Icons.perm_contact_calendar_outlined,
                    color: Colors.black26,
                  ),
                  text: snapshot.data == 'petugas' ? "Jadwal" : "Petugas"),
              FABBottomAppBarItem(
                  activeIcon: Icon(
                    Icons.list_alt_outlined,
                    color: Colors.green,
                  ),
                  inActiveIcon: Icon(
                    Icons.list_alt_outlined,
                    color: Colors.black26,
                  ),
                  text: 'Aktivitas'),
              FABBottomAppBarItem(
                  activeIcon: Icon(
                    Icons.supervised_user_circle_outlined,
                    color: Colors.green,
                  ),
                  inActiveIcon: Icon(
                    Icons.supervised_user_circle_outlined,
                    color: Colors.black26,
                  ),
                  text: 'Profil'),
            ],
            bodyItems: [
              snapshot.data == 'petugas' ? HomePetugasPage() : HomeWarga(),
              snapshot.data == 'petugas' ? StackOver() : DaftarPetugasPage(),
              snapshot.data == 'petugas' ? ActivityPage() : AktifitasWarga(),
              snapshot.data == 'petugas'
                  ? ProfilePetugasPage()
                  : ProfileWargaPage(),
            ],
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Future<String?> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? role = prefs.getString('role');
    return role;
  }
}
