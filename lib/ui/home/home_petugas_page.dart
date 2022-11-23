
import 'dart:io';
import 'package:boilerplate/controllers/petugas_controller.dart';
import 'package:boilerplate/ui/home/area_id.dart';
import 'package:boilerplate/ui/help/help_petugas.dart';
import 'package:boilerplate/ui/home/saran_masukan.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class HomePetugasPage extends StatefulWidget {
  const HomePetugasPage({Key? key}) : super(key: key);

  @override
  State<HomePetugasPage> createState() => _HomePetugasPageState();
}

class _HomePetugasPageState extends State<HomePetugasPage> {
  String? code;
  //lebar dan tinggi layar
  final ref = FirebaseDatabase.instance
      .ref()
      .child('jadwal')
      .orderByChild('date')
      .equalTo(DateFormat('dd/MM/yyyy').format(DateTime.now()).toString())
      .limitToLast(4);
  File? _image;
  String? fileName;

  int _activeIndex = 0;
  final imageAsset = [
    'assets/images/slide1.png',
    'assets/images/slide2.png',
    'assets/images/slide3.png'
  ];

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3)).then((_) {
      //return data from user code
      PetugasController().getPetugasCode().then((value) {
        setState(() {
          //input
          print("Ini value" + value.toString());
          code = value;
        });
      }).then((value) {
        if (code == null) {
          //show dialog
          showDialog(
            context: this.context,
            builder: (context) {
              return AlertDialog(
                content: AreaId(code: code),
              );
            },
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          FutureBuilder(
              future: PetugasController().getPetugasByUid(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        //shared preference simpan id user
                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setInt('user_id', snapshot.data[index].user.id);
                          prefs.setInt("petugas_id", snapshot.data[index].id);
                          prefs.setString('code', snapshot.data[index].code);
                        });
                        // print("ini petugas id" +
                        //     snapshot.data[index].id.toString());
                        code = snapshot.data[index].code;
                        return Column(children: [
                          //Bagian paling atas form,logo dan notifikasi
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/images/group_logo.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.200,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20))),
                                      backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                      context: context,
                                      builder: (_) {
                                        return FractionallySizedBox(
                                          heightFactor: 0.9,
                                          child: AreaId(
                                            code: code,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text("PENS",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 10,
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 13),
                                  alignment: Alignment.centerRight,
                                  child: Stack(children: [
                                    //Notification
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.notifications,
                                        color: Colors.black45,
                                        size: 32,
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 2)),
                                        child: Center(
                                          child: Text(
                                            "1",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          ),

                          //Bagian 2, nama petugas
                          Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 88,
                            decoration: BoxDecoration(
                                color: Color(0xFF004C58),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 5),
                                      blurRadius: 10)
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 6),
                                  child: snapshot.data[index].user.photo != null
                                      ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data[index].user.photo),
                                    radius: 27,
                                  )
                                      : CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/images/grup_logo2.png')),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text(
                                          snapshot.data[index].user.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.04,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Petugas",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                    width: MediaQuery.of(context).size.width *
                                        0.37,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      border: Border.all(
                                        width: 0,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top:
                                              MediaQuery.of(context).size.width *
                                                  0.02,
                                                  left: MediaQuery.of(context).size.width *
                                                      0.01
                                          ),
                                          child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.black45,
                                                  size: MediaQuery.of(context).size.width *
                                                      0.05,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Penempatan Kerja", style: TextStyle(fontSize: MediaQuery.of(context).size.width *
                                                        0.030, fontWeight: FontWeight.w500),),
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("D4 PENS", style: TextStyle(fontSize: MediaQuery.of(context).size.width *
                                                            0.03, fontWeight: FontWeight.w300),),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.09),
                                                        IconButton(
                                                            padding: EdgeInsets.zero,
                                                            constraints: BoxConstraints(),
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.create_rounded,
                                                              color: Colors.black45,
                                                              size: MediaQuery.of(context).size.width *
                                                                  0.05,
                                                            )
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              ]
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                          ),
                        ]);
                      });
                } else {
                  return Column(
                    children: [
                      ListTileShimmer(),
                      ListTileShimmer(),
                      ListTileShimmer(),
                    ],
                  );
                }
              }),

          Container(
            margin: EdgeInsets.only(top: 5, left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              "Tugas Terbaru Anda",
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            height: MediaQuery.of(context).size.height * 0.14,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Color(0xff4BB051),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ]),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                        EdgeInsets.only(top: 5, left: 8),
                        child: Text(
                          "Piket Pagi",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 2, left: 8),
                        child: Row(
                          //space between cleaning service dan petugas
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Selesai",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.6,
                                ),
                                Icon(
                                  Icons.done_all,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 8, left: 8),
                        child: Text(
                          "Piket Siang",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 2, left: 8),
                        child: Row(
                          //space between cleaning service dan petugas
                          children: [
                            Row(
                              children: [
                                Text(
                                  "senin, 12/12/2020",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.42,
                                ),
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5, left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              "Manfaat Pick A Bin",
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            child: CarouselSlider.builder(
              itemCount: imageAsset.length,
              options: CarouselOptions(
                height: 120.0,
                viewportFraction: 1,
                aspectRatio: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) {
                  setState(() {
                    _activeIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return _buildImage(imageAsset, index);
              },
            ),
          ),
          HelpPetugas(),
          Container(
            margin: EdgeInsets.only(bottom: 5, left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              "Sampaikan Aspirasi",
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 12),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff4BB051),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff4BB051),
                    offset: const Offset(0.0, 0.8),
                    blurRadius: 2.0,
                    spreadRadius: 1.2)
              ],
            ),

            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 5),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1DDB7F),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SaranMasukan();
                            });
                      },
                      child: Text("Lihat Detail"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/images/aspiration.png",
                          width: 115, height: 115)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90, bottom: 50),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 200,
                      child: Text(
                        "Sampaikan aspirasi Anda !\n\nAnda dapat menyampaikan saran dan masukan",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        maxLines: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildImage(List<String> imageAsset, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage(
                imageAsset[index],
              ),
              fit: BoxFit.cover)),
    );
  }
}