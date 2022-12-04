import 'package:boilerplate/models/lapor_kotor.dart';
import 'package:boilerplate/ui/notifikasi/feedback_petugas.dart';
import 'package:boilerplate/ui/notifikasi/lapor_kotor_page.dart';
import 'package:boilerplate/ui/notifikasi/notif_acara.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({Key? key}) : super(key: key);

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  String? role;
   
   @override
  void initState() {
    super.initState();
    _getRole();
  }

  @override
  Widget build(BuildContext context) {
    // shared preferences role user
    return DefaultTabController(
      length: role == "petugas" ? 3 : 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          bottom: role == "petugas" ? TabBar(
            tabs: [
              Tab(text: 'Lapor Kotor'),
              Tab(text: 'Lapor Acara'),
              Tab(text: 'Feedback Tugas'),
            ],
          ) : TabBar(
            tabs: [
              Tab(text: 'Lapor Kotor'),
              Tab(text: 'Lapor Acara'),
            ],
          ),
          title: Text('Notifikasi'),
        ),
        body: role == "petugas" ? TabBarView(
          children: [
            Padding(padding: EdgeInsets.only(top: 10), child: LaporKotorPage()),
            Padding(padding: EdgeInsets.only(top: 10), child: NotifAcara()),
            Padding(padding: EdgeInsets.only(top: 10), child: FeedbackPetugas()),
          ],
        ) : TabBarView(
          children: [
            Padding(padding: EdgeInsets.only(top: 10), child: LaporKotorPage()),
            Padding(padding: EdgeInsets.only(top: 10), child: NotifAcara()),
          ],
        ),
      ),
    );
  }

    Future<String?> _getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? role = prefs.getString('role');
    setState(() {
      this.role = role;
    });
    return role;
  }
}
