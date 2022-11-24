import 'package:flutter/material.dart';

class KoordinatorLaporanTutorial extends StatefulWidget {
  @override
  _KoordinatorLaporanTutorialState createState() =>
      _KoordinatorLaporanTutorialState();
}

class _KoordinatorLaporanTutorialState
    extends State<KoordinatorLaporanTutorial> {
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
          title: Text("Fitur Laporan"),
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
                        "assets/images/lapor_petugas_main.png",
                        width: 300.0,
                        height: 150.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Tutorial Fitur Laporan Petugas\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Fitur ini digunakan oleh koordinator petugas untuk memantau kinerja dari petugas kebersiihan lainnya\n",
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
                              'assets/images/lapor_petugas1.png',
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 90,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
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
                              'assets/images/lapor_petugas2.png',
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 90,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "Akan muncul nama dari petugas kebersihan yang sudah menyelesaikan tugasnya",
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
                              'assets/images/lapor_petugas4.png',
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 90,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "Bukti unggahan foto yang diunggah oleh petugas dapat diakses pada bagian kanan setiap list nama petugas",
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
                              'assets/images/lapor_petugas4.png',
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 90,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "Apabila terdapat kendala, dapat menghubungi petugas kebersihan ke halaman profile lalu klik kontak petugas",
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    maxLines: 5,
                                  ),
                                )),
                          ],
                        )),
                    SizedBox(height: 20),
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
