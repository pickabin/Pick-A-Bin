import 'package:boilerplate/controllers/koor_gedung_controller.dart';
import 'package:boilerplate/controllers/petugas_controller.dart';
import 'package:boilerplate/controllers/user_controller.dart';
import 'package:boilerplate/ui/login/login_petugas_page.dart';
import 'package:boilerplate/ui/login/login_koordinator_page.dart';
import 'package:boilerplate/ui/navbar/navbar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  //get current User ID
  Future<String?> getCurrentUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    return uid;
  }

  // Future<String?> getCurrentEmail () async {
  //   String? _userEmail = FirebaseAuth.instance.currentUser?.email;
  //   return _userEmail;
  // }

  void loginUserKoordinator(context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => {
                print("Login Successfully"),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => NavbarPage()))
              });
    } catch (e) {
      // print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Username atau Password Salah"),
            content: Text("Pastikan Username dan Password Anda Benar"),
            actions: <Widget>[
              TextButton(
                child: Text("Close"),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          LoginKoordinatorPage()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  void loginUserPetugas(context) async {
    try {
      AlertDialog(
        title: Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.green,
        )),
      );

      await _auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => {
                print("Login Successfully"),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => NavbarPage()))
              });
    } catch (e) {
      // print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Username atau Password Salah"),
            content: Text("Pastikan Username dan Password Anda Benar"),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPetugasPage()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> registerKoordinator(
      String nama, String email, String password) async {
    try {
      //cek jika ada duplikat email

      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(nama);
      //get uid from register firebase
      print("ini uid " + newUser.user!.uid);

      CollectionReference koordinator =
          FirebaseFirestore.instance.collection('koordinator');
      koordinator
          .add({
            'nama': nama,
            'email': email,
            'uid': newUser.user!.uid,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      UserController.addUser(newUser.user!.uid, nama, email, password)
          .then((value) {
        KoorGedungController.addKoorGedung(newUser.user!.uid).then((value) {
          Fluttertoast.showToast(
            msg: "Registration Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      });
      // KoorGedungController.addUser(nama, email, password);
      // DatabaseReference data = FirebaseDatabase.instance.ref("warga");
      // data.push().set({
      //   "nama": nama,
      //   "email": email,
      //   "password": password,
      // });
      // DatabaseReference dataJadwal = FirebaseDatabase.instance.ref("jadwal");
      // dataJadwal.push().set({
      //   "instansi": namaInstansi,
      //   "penanggungJawab": penanggungJawab,
      //   "alamat": location,
      //   "email": email,
      //   "telp": telp,
      //   "status": false,
      //   "date": DateFormat('dd/MM/yyyy').format(DateTime.now()),
      //   "jarakPengambilan": jarakPengambilan,
      //   "konfirmasi": false,
      // });

      //  CollectionReference lokasi = FirebaseFirestore.instance.collection('lokasi');
      // lokasi.add({
      //   "penanggungJawab": penanggungJawab,
      //   "alamat": location,
      //   "lat": lat,
      //   "long": long,
      // });

      return "Registration Successfully";
      //Register Successful Notification

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "Email already in use",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromARGB(255, 231, 56, 43),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return "Email already in use";
        // return 'The account already exists for that email.';
      } else {
        Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return "Registration Failed";
      }
    }
  }

  Future<String> registerPetugas(
      String nama, String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(nama);
      //get uid from register firebase
      print("ini uid " + newUser.user!.uid);
      CollectionReference petugas =
          FirebaseFirestore.instance.collection('petugas');
      // data.push().set({
      //   "nama": namaLengkap,
      //   "alamat": alamat,
      //   "email": email,
      //   "telp": telp,
      //   'status': "petugas"
      // });
      petugas
          .add({
            'nama': nama,
            'email': email,
            'uid': newUser.user!.uid,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      UserController.addUser(newUser.user!.uid, nama, email, password)
          .then((value) {
        PetugasController.addPetugas(newUser.user!.uid).then((value) {
          Fluttertoast.showToast(
            msg: "Registration Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      });

      return "Registration Successfully";
      //Register Successful Notification

    } on FirebaseAuthException catch (e) {
      //cek jika ada duplikat email
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "Email already in use",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromARGB(255, 231, 56, 43),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return "Email already in use";
        // return 'The account already exists for that email.';
      } else {
        Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return "Registration Failed";
      }
    }
  }

  //Reset Password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "Sending password reset link successful",
        toastLength: Toast.LENGTH_SHORT,
      );
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  //Update Profile email
  // Future updateEmail(String email) async {
  //   try {
  //     await _auth.currentUser?.updateEmail(email);
  //     Fluttertoast.showToast(msg: "Update Profile Successfully",toastLength: Toast.LENGTH_SHORT);
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  //Update Profile displayName
  Future updateDisplayName(String nama) async {
    try {
      await _auth.currentUser?.updateDisplayName(nama);
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
