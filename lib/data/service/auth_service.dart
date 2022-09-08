import 'package:boilerplate/ui/login/login_petugas_page.dart';
import 'package:boilerplate/ui/login/login_warga_page.dart';
import 'package:boilerplate/ui/navbar/navbar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  //get current User ID
  Future<String?> getCurrentUID() async {
    final User? user = await _auth.currentUser;
    return user?.uid;
  }

  // Future<String?> getCurrentEmail () async {
  //   String? _userEmail = FirebaseAuth.instance.currentUser?.email;
  //   return _userEmail;
  // }

  void loginUserWarga(context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) => {
                print("Login Successfully"),
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => NavbarPage()))
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
              FlatButton(
                child: Text("Close"),
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginWargaPage()));
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
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => NavbarPage()))
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
              FlatButton(
                child: Text("Close"),
                color: Colors.red,
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

  Future<String> registerWarga(String namaInstansi,String penanggungJawab,String email,String password,
      String location,String telp,String jarakPengambilan, double? lat, double? long) async {
    try {
      //cek jika ada duplikat email

      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(penanggungJawab);
      DatabaseReference data = FirebaseDatabase.instance.ref("warga");
      data.push().set({
        "instansi": namaInstansi,
        "penanggungJawab": penanggungJawab,
        "alamat": location,
        "email": email,
        "telp": telp,
        "jarakPengambilan": jarakPengambilan,
        "lat": lat,
        "long": long,
      });
      DatabaseReference dataJadwal = FirebaseDatabase.instance.ref("jadwal");
      dataJadwal.push().set({
        "instansi": namaInstansi,
        "penanggungJawab": penanggungJawab,
        "alamat": location,
        "email": email,
        "telp": telp,
        "status": false,
        "date": DateFormat('dd/MM/yyyy').format(DateTime.now()),
        "jarakPengambilan": jarakPengambilan,
        "konfirmasi": false,
      });

      Fluttertoast.showToast(
        msg: "Registration Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
      }else{
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

  Future<String> registerPetugas(String namaLengkap, String alamat,
      String email, String password, String telp) async {
    try {
      
                                        

      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(namaLengkap);
      DatabaseReference data = FirebaseDatabase.instance.ref("petugas");
      data.push().set({
        "nama": namaLengkap,
        "alamat": alamat,
        "email": email,
        "telp": telp,
        'status': "petugas"
      });

      Fluttertoast.showToast(
        msg: "Registration Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
  
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
      }else{
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
      return e.toString();
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
      Fluttertoast.showToast(
        msg: "Update Profile Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
