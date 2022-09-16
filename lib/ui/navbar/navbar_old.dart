import 'package:boilerplate/data/network/exceptions/connectivity_provider.dart';
import 'package:boilerplate/ui/activity/activity_page.dart';
import 'package:boilerplate/ui/activity/user_activity_page.dart';
import 'package:boilerplate/ui/connection/error_connection.dart';
import 'package:boilerplate/ui/home/home_petugas_page.dart';
import 'package:boilerplate/ui/home/home_warga_page.dart';
import 'package:boilerplate/ui/home/daftar_petugas_page.dart';
import 'package:boilerplate/ui/profile/profile_petugas_page.dart';
import 'package:boilerplate/ui/profile/profile_warga_page.dart';
import 'package:boilerplate/ui/schedule/stack_over.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
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
    ActivityPage(),
    ProfilePetugasPage(),
  ];

  final _pageOptionsWarga = [
    HomeWargaPage(),
    DaftarPetugasPage(),
    UserActivityPage(),
    ProfileWargaPage(),
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
                            : _pageOptionsWarga[selectedPage],
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
                                  : Icon(Icons.perm_contact_calendar_outlined),
                              label: snapshot.data == 'petugas'
                                  ? "Jadwal"
                                  : "Petugas",
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.list_alt_outlined),
                              label: 'Aktivitas',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.supervised_user_circle_outlined),
                              label: 'Profile',
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
