import 'package:boilerplate/models/lapor_kotor.dart';
import 'package:boilerplate/ui/notifikasi/feedback_petugas.dart';
import 'package:boilerplate/ui/notifikasi/lapor_kotor_page.dart';
import 'package:boilerplate/ui/notifikasi/notif_acara.dart';
import 'package:flutter/material.dart';

class Notifikasi extends StatelessWidget {
  const Notifikasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Lapor Kotor'),
              Tab(text: 'Lapor Acara'),
              Tab(text: 'Feedback Tugas'),
            ],
          ),
          title: Text('Notifikasi'),
        ),
        body: TabBarView(
          children: [
            Padding(padding: EdgeInsets.only(top: 10), child: LaporKotorPage()),
            Padding(padding: EdgeInsets.only(top: 10), child: NotifAcara()),
            Padding(padding: EdgeInsets.only(top: 10), child: FeedbackPetugas()),
          ],
        ),
      ),
    );
  }
}
