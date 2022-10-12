import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 9,185, 100),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Fitur Jadwal"),
        ),
        backgroundColor: Color.fromARGB(255, 9,185, 100),
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
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/activity_icon.png",
                        width: 300.0,
                        height: 150.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Jadwal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18, left: 18, right: 18),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Tutorial Penggunaan Fitur Jadwal\n\n",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Image.asset('assets/images/activity_icon.png', width: 70, height: 70,),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Masuk ke Halaman Jadwal",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Image.asset('assets/images/activity_icon.png', width: 70, height: 70,),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Klik Icon Foto",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Image.asset('assets/images/activity_icon.png', width: 70, height: 70,),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  child: Container(
                                    width: 200,
                                    child: Text(
                                      "Posisikan kamera ke tempat yang sudah dibersihkan dan klik",
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15
                                      ),
                                      maxLines: 2,
                                    ),
                                  )
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Image.asset('assets/images/activity_icon.png', width: 70, height: 70,),
                                Container(
                                    margin: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      width: 230,
                                      child: Text(
                                        "Muncul preview foto yang sudah diklik sebelumnya. Apabila ada kesalahan bisa klik ulang di icon pojok kiri. Apabila sudah benar klik centang",
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15
                                        ),
                                        maxLines: 4,
                                      ),
                                    )
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Image.asset('assets/images/activity_icon.png', width: 70, height: 70,),
                                Container(
                                    margin: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      width: 230,
                                      child: Text(
                                        "Data sudah terkirim akan masuk ke halaman History aktivitas",
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15
                                        ),
                                        maxLines: 4,
                                      ),
                                    )
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 8, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )),
          ],
        ));
  }
}
