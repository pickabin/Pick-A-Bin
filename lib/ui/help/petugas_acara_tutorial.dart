import 'package:flutter/material.dart';

class PetugasAcaraTutorial extends StatefulWidget {
  @override
  _PetugasAcaraTutorialState createState() => _PetugasAcaraTutorialState();
}

class _PetugasAcaraTutorialState extends State<PetugasAcaraTutorial> {
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
          title: Text("Fitur Laporan Acara"),
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
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/lapor_acara_main.png",
                        width: 350.0,
                        height: 200.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Tutorial Laporan Acara\n",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Fitur ini berfungsi untuk menampilkan acara apa saja yang akan diadakan\n",
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
            Expanded(
                child: Padding(
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
                                Image.asset('assets/images/lapor_acara1.png', width: 90, height: 90,),
                                Container(
                                    margin: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      width: 200,
                                      child: Text(
                                        "Terdapat laporan yang diadukan oleh warga",
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15
                                        ),
                                        maxLines: 3,
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
                                Image.asset('assets/images/lapor_acara2.png', width: 90, height: 90,),
                                Container(
                                    margin: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      width: 200,
                                      child: Text(
                                        "Laporan muncul pada menu acara beserta rincian waktunya",
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15
                                        ),
                                        maxLines: 3,
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
                                Image.asset('assets/images/lapor_acara3.png', width: 90, height: 90,),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  child: Container(
                                    width: 200,
                                    child: Text(
                                      "Ketika waktu sudah tiba, acara tersebut akan secara otomatis muncul dihalaman jadwal",
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15
                                      ),
                                      maxLines: 3,
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
