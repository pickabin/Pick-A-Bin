import 'package:flutter/material.dart';

class PetugasScheduleTutorial extends StatefulWidget {
  @override
  _PetugasScheduleTutorialState createState() =>
      _PetugasScheduleTutorialState();
}

class _PetugasScheduleTutorialState extends State<PetugasScheduleTutorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 9, 185, 100),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Fitur Jadwal"),
        ),
        backgroundColor: Color.fromARGB(255, 9, 185, 100),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 8, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/jadwal_petugas_main.png",
                        width: 300.0,
                        height: 150.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Tutorial Penggunaan Fitur Jadwal\n",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Fitur ini serupa dengan absensi untuk petugas kebersihan, melaporkan kepada koordinator untuk terselesaikannya tugas\n",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18, left: 10, right: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/Tutor1.png',
                              width: 90,
                              height: 90,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width: 200,
                                  child: Text(
                                    "Masuk ke Halaman Jadwal yang ada pada menu bagian tengah",
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    maxLines: 3,
                                  ),
                                )),
                          ],
                        )),
                    SizedBox(height: 20),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/tutor2.png',
                              width: 90,
                              height: 90,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width: 200,
                                  child: Text(
                                    "Pada list yang sudah tersedia, klik icon foto untuk mengambil gambar",
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    maxLines: 3,
                                  ),
                                )),
                          ],
                        )),
                    SizedBox(height: 20),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/Tutor3.png',
                              width: 90,
                              height: 90,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width: 200,
                                  child: Text(
                                    "Posisikan kamera ke tempat yang sudah dibersihkan dan klik",
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    maxLines: 3,
                                  ),
                                )),
                          ],
                        )),
                    SizedBox(height: 20),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/Tutor4.png',
                              width: 90,
                              height: 90,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width: 200,
                                  child: Text(
                                    "Muncul preview foto yang sudah diklik sebelumnya. Apabila ada kesalahan bisa klik ulang di icon pojok kiri. Apabila sudah benar klik centang",
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    maxLines: 4,
                                  ),
                                )),
                          ],
                        )),
                    SizedBox(height: 20),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/Tutor5.png',
                              width: 90,
                              height: 90,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width: 200,
                                  child: Text(
                                    "Data sudah terkirim akan masuk ke halaman History aktivitas",
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    maxLines: 4,
                                  ),
                                )),
                          ],
                        )),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 8, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ));
  }
}
