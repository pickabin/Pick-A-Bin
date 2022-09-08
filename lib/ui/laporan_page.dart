import 'package:boilerplate/data/service/auth_service.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/ui/authentication/choose_role.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  //Read data once from Realtime Database
  final ref = FirebaseDatabase.instance.ref().child('warga');
  AuthService authService = AuthService();
   //get email from shared preferences
  
  
  
  
  

  @override
  // DatabaseReference ref = FirebaseDatabase.instance.ref("petugas/1001");
  // Future<void> initState() async {
  //   super.initState();
  //   DatabaseEvent event = await ref.once();
  // }

 //get email from shared preference
//  Future<String?> getEmail() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String? email = prefs.getString('email');
//    return email;
//  }

  
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Laporan',
            style: TextStyle(color: Color(0xff00783E)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: FutureBuilder(
        future: _getPrefs(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            print(snapshot.data);
            return FirebaseAnimatedList(
          //get email from shared preference
          query: ref.orderByChild('email').equalTo("${snapshot.data}"),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {

            return Column(
            children: [
              const SizedBox(
                height: 60.0,
              ),
            ],
          );
        });
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
       }),
    );
  }

  Future<String?> 
  _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }
}