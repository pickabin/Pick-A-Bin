import 'package:boilerplate/data/network/exceptions/connectivity_provider.dart';
import 'package:boilerplate/ui/activity/activity_page.dart';
import 'package:boilerplate/ui/activity/user_activity_page.dart';
import 'package:boilerplate/ui/connection/error_connection.dart';
import 'package:boilerplate/ui/home/daftar_petugas_page.dart';
import 'package:boilerplate/ui/home/detail_acara.dart';
import 'package:boilerplate/ui/home/home_petugas_page.dart';
import 'package:boilerplate/ui/home/home_warga_page.dart';
import 'package:boilerplate/ui/schedule/notif_acara.dart';
import 'package:boilerplate/ui/profile/profile_petugas_main.dart';
import 'package:boilerplate/ui/profile/profile_warga_main.dart';
import 'package:boilerplate/ui/schedule/schedule_page.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavbarPage extends StatefulWidget {
  @override
  _NavbarPageState createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false)
        .pantauConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, value, child) {
      return value.isOnline ? WillPopScope(
        onWillPop: () => _onWillPop(),
        child: FutureBuilder(
          future: _getRole(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return CurvedNavBar(
                actionButton: CurvedActionBar(
                  onTab: (value) {
                    /// perform action here
                    snapshot.data == 'petugas'
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SchedulePage()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailAcara(lat: null, location: '', long: null,)));
                  },
                  activeIcon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: snapshot.data == "petugas"
                        ? Icon(
                            Icons.calendar_month_outlined,
                            size: 45,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.menu_book_outlined,
                            size: 45,
                            color: Colors.white,
                          ),
                  ),
                  inActiveIcon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: snapshot.data == "petugas"
                        ? Icon(
                            Icons.calendar_month_outlined,
                            size: 45,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.menu_book_outlined,
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
                                  ? Icons.format_list_bulleted
                                  : Icons.calendar_month_outlined,
                              color: Colors.green,
                            ),
                            inActiveIcon: Icon(
                              snapshot.data == 'petugas'
                                  ? Icons.format_list_bulleted
                                  : Icons.calendar_month_outlined,
                              color: Colors.black26,
                            ),
                            text: snapshot.data == 'petugas'
                                ? "Acara"
                                : "Jadwal"),
                        FABBottomAppBarItem(
                            activeIcon: Icon(
                              Icons.list_alt_outlined,
                              color: Colors.green,
                            ),
                            inActiveIcon: Icon(
                              Icons.list_alt_outlined,
                              color: Colors.black26,
                            ),
                            text: 'History'),
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
                        snapshot.data == 'petugas'
                            ? HomePetugasPage()
                            : HomeWargaPage(),
                        snapshot.data == 'petugas'
                            ? NotifAcara()
                            : DaftarPetugasPage(),
                        snapshot.data == 'petugas'
                            ? ActivityPage()
                            : UserActivityPage(),
                        snapshot.data == 'petugas'
                            ? ProfilePetugasMain()
                            : ProfileWargaMain(),
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
              ),
            )
          : ErrorConnection();
    });
  }

  Future<String?> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? role = prefs.getString('role');
    return role;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
