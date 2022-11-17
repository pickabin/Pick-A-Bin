import 'package:boilerplate/data/network/exceptions/connectivity_provider.dart';
import 'package:boilerplate/ui/activity/petugas_activity_page.dart';
import 'package:boilerplate/ui/activity/koor_activity_page.dart';
import 'package:boilerplate/ui/connection/error_connection.dart';
import 'package:boilerplate/ui/home/home_petugas_page.dart';
import 'package:boilerplate/ui/home/home_koordinator_page.dart';
import 'package:boilerplate/ui/profile/profile_petugas_main.dart';
import 'package:boilerplate/ui/profile/profile_koordinator_main.dart';
import 'package:boilerplate/ui/schedule/jadwal_petugas_camera_page.dart';
import 'package:boilerplate/ui/notifikasi/notif_acara.dart';
import 'package:boilerplate/ui/schedule/stack_over.dart';
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

  int selectedPage = 0;

  final _pageOptionsPetugas = [
    HomePetugasPage(),
    StackOver(),
    PetugasActivityPage(),
    ProfilePetugasMain()
  ];

  final _pageOptionsKoordinator = [
    HomeKoordinatorPage(),
    StackOver(),
    KoorActivityPage(),
    ProfileKoordinatorMain()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, value, child) {
        return value.isOnline
            ? WillPopScope(
                onWillPop: () => _onWillPop(),
                child: FutureBuilder(
                  future: _getRole(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return Scaffold(
                        backgroundColor: Colors.white,
                        body: snapshot.data == 'petugas'
                            ? _pageOptionsPetugas[selectedPage]
                            : _pageOptionsKoordinator[selectedPage],
                        bottomNavigationBar: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          items: <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home_outlined),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: snapshot.data == 'petugas'
                                  ? Icon(Icons.calendar_month_outlined)
                                  : Icon(Icons.calendar_month_outlined),
                              label: snapshot.data == 'petugas'
                                  ? "Jadwal"
                                  : "Jadwal",
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.update_rounded),
                              label: 'Riwayat',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.person),
                              label: 'Profil',
                            ),
                          ],
                          showUnselectedLabels: true,
                          currentIndex: selectedPage,
                          unselectedItemColor: Colors.grey,
                          selectedItemColor: Colors.green,
                          onTap: (index) {
                            setState(() {
                              selectedPage = index;
                            });
                          },
                        ),
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
      },
    );
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
